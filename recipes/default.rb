require_recipe "git"

bash 'install_gitolite' do
  cwd "/tmp"
  code <<-EOH
    rm -rf gitolite-source
    git clone git://github.com/sitaramc/gitolite gitolite-source
    cd gitolite-source
    git checkout -t -f origin/pu
    mkdir -p /usr/local/share/gitolite/conf /usr/local/share/gitolite/hooks
    src/gl-system-install /usr/local/bin /usr/local/share/gitolite/conf /usr/local/share/gitolite/hooks
  EOH
  creates '/usr/local/bin/gl-setup'
end

