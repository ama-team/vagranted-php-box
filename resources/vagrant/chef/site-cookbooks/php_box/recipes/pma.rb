#
# Cookbook Name:: php_box
# Recipe:: nginx
#
# Copyright 2017, AMA Team
#
# All rights reserved - Do Not Redistribute
#

package 'unzip'

directory '/tmp/pma' do
  recursive true
end

directory '/var/www/pma' do
  recursive true
end

execute 'pma:move' do
  command 'find /tmp/pma -mindepth 2 -maxdepth 2 -exec mv -f {} /var/www/pma \;'
  action :nothing
end

execute 'pma:extraction' do
  command 'unzip -o /var/cache/pma.zip -d /var/www/pma'
  action :nothing
  notifies :run, 'execute[pma:move]', :immediately
end

version = node['services']['pma']['version']
remote_file "/var/cache/pma-#{version}.zip" do
  source "https://files.phpmyadmin.net/phpMyAdmin/#{version}/phpMyAdmin-#{version}-all-languages.zip"
  notifies :run, 'execute[pma:extraction]', :immediately
  not_if "[ -f /var/cache/pma-#{version}.zip ]"
end

template '/var/www/pma/config.inc.php' do
  source 'pma/config.php.erb'
  variables({
      mysql: node['services']['mysql']
  })
end
