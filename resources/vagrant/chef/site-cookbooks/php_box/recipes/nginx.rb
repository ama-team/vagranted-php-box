#
# Cookbook Name:: php_box
# Recipe:: nginx
#
# Copyright 2017, AMA Team
#
# All rights reserved - Do Not Redistribute
#

package 'nginx'

service 'nginx' do
  action :nothing
end

template '/etc/nginx/fcgi.conf' do
  source 'nginx/fcgi.conf.erb'
end

template '/etc/nginx/sites-available/_pma' do
  source 'nginx/pma.conf.erb'
  variables node['services']['nginx']
  notifies :restart, 'service[nginx]', :delayed
end

link '/etc/nginx/sites-enabled/_pma' do
  to '/etc/nginx/sites-available/_pma'
end

template '/etc/nginx/sites-available/default' do
  source 'nginx/ingress.conf.erb'
  variables node['services']['nginx']
  notifies :restart, 'service[nginx]', :delayed
end
