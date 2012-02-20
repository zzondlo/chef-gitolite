action :create do
  user = new_resource.user
  admin = new_resource.admin
  key = new_resource.key
  key_path = new_resource.key_path

  # Create the user
  user user do
    comment "gitolite user - #{user}"
    home "/home/#{user}"
    shell "/bin/bash"
  end

  # And its folder
  directory "/home/#{user}" do
    owner user
    action :create
  end
  
  # gitolite_rc ?
  template "/home/#{user}/.gitolite.rc" do
      owner user
      source "gitolite.rc.erb"
      action :create
  end

  # Read key from file is not specified
  key = key || IO.read(key_path)
  file "/tmp/gitolite-#{admin}.pub" do
    owner user
    content key
  end

  # Installing gitolite
  execute "installing_gitolite_for" do
    user user
    command "/usr/local/bin/gl-setup /tmp/gitolite-#{admin}.pub"
    environment ({'HOME' => "/home/#{user}"})
  end
end

action :delete do

end
