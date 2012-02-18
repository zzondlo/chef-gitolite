include_recipe "git"

bash 'install_gitolite' do
  cwd "/tmp"
  code <<-EOH
    rm -rf gitolite-source
    git clone git://github.com/sitaramc/gitolite gitolite-source
    cd gitolite-source
    git checkout -t -f origin/pu
    mkdir -p #{node[:gitolite][:path][:conf]} #{node[:gitolite][:path][:hook]}
    src/gl-system-install #{node[:gitolite][:path][:bin]} #{node[:gitolite][:path][:conf]} #{node[:gitolite][:path][:hook]}
  EOH
  creates '/usr/local/bin/gl-setup'
end

