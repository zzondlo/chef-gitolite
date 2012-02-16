define :gitolite_instance do
  # Create the user
  user params[:user] do
    comment "gitolite user - #{params[:user]} "
    home "/home/#{params[:user]}"
    shell "/bin/bash"
	  system true
    action :create
  end

  # And its folder
  directory "/home/#{params[:user]}" do
    owner params[:user]
    action :create
  end
  
  # gitolite_rc ?
  template "/home/#{params[:user]}/.gitolite.rc" do
      owner params[:user]
      source "gitolite.rc.erb"
      action :create
  end

if params[:admin_key] = nil
  # try and read the key
  params[:admin_key] = IO.read("/home/params[:admin]/.ssh/id_rsa.pub")
end
 
  # prepare admin key
  file "/tmp/gitolite-#{params[:admin]}.pub" do
    owner params[:user]
    content params[:admin_key]
  end

  # Installing gitolite
  execute "installing_gitolite_for" do
    user params[:user]
    command "/usr/local/bin/gl-setup /tmp/gitolite-#{params[:admin]}.pub"
    environment ({'HOME' => "/home/#{params[:user]}"})
  end
end
