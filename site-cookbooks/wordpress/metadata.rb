maintainer       "Lukasz Kaniowski"
maintainer_email "lukasz.kaniowski@gmail.com"
license          "Apache 2.0"
description      "Installs wordpress stack"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe "wordpress", "Installs and configures wordpress LAMP stack on a single system"

%w{ php apache2 database apt}.each do |cb|
  depends cb
end


%w{ debian ubuntu redhat centos fedora }.each do |os|
  supports os
end

