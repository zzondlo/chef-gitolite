define :gitolite_instance, :admin_key => nil do
  # Create the user
  user params[:user] do
    gid params[:user]
    comment "gitolite user - #{params[:user]} "
    home "/home/#{params[:user]}"
    shell "/bin/bash"
    action :create
    system true
    password nil
  end

  # And its folder
  directory "/home/#{params[:user]}" do
    owner params[:user]
    group params[:user]
    action :create
  end
  
  # gitolite_rc ?
  template "/home/#{params[:user]}/.gitolite.rc" do
      owner params[:user]
      source "gitolite.rc.erb"
      action :create
  end

  # prepare admin key
  file "/tmp/gitolite-#{params[:admin]}.pub" do
    owner params[:user]
    if params[:admin_key].nil?
      key=IO.read("/home/#{params[:admin]}/.ssh/id_rsa.pub")
    else
      key = params[:admin_key]
    end
    content key
  end

  # Installing gitolite
  execute "installing_gitolite_for" do
    user params[:user]
    command "/usr/local/bin/gl-setup /tmp/gitolite-#{params[:admin]}.pub"
    environment ({'HOME' => "/home/#{params[:user]}"})
  end
end
