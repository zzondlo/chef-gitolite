maintainer        "Antoine Roy-Gobeil"
maintainer_email  "roygobeil.antoine@gmail.com"
license           "Apache 2.0"
description       "Installs/Configures gitolite"
version           "0.0.1"

%w{ ubuntu }.each do |os|
  supports os
end

%w{ git }.each do |cb|
  depends cb
end
