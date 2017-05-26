#
# Cookbook Name:: php_box
# Recipe:: mysql
#
# Copyright 2017, AMA Team
#
# All rights reserved - Do Not Redistribute
#

password = node['services']['mysql']['password']

execute 'mysql:install:prepare' do
  command <<-EOF
    echo 'mysql-server mysql-server/root_password password #{password}' | sudo debconf-set-selections
    echo 'mysql-server mysql-server/root_password_again password #{password}' | sudo debconf-set-selections
  EOF
end

package 'mysql-server'

service 'mysql' do
  action :nothing
end

template '/etc/mysql/conf.d/mysql.cnf' do
  source 'mysql/mysql.cnf.erb'
  variables node['services']['mysql']
  notifies :restart, 'service[mysql]', :immediately
end

execute "mysql -uroot '-p#{password}' -e 'CREATE DATABASE IF NOT EXISTS application CHARACTER SET utf8 COLLATE utf8_general_ci;'"
