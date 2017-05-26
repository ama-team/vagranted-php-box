#
# Cookbook Name:: php_box
# Recipe:: php
#
# Copyright 2017, AMA Team
#
# All rights reserved - Do Not Redistribute
#

package 'php-fpm'
%w(
  mysql
  gd
  imagick
  mbstring
  mcrypt
  json
  intl
  gettext
  bcmath
  bz2
  xdebug
).each do |id|
  package "php-#{id}"
end

service 'php7.0-fpm' do
  action :nothing
end

%w(cli fpm).each do |variant|
  template "/etc/php/7.0/#{variant}/conf.d/99-customization.ini" do
    source 'php/customization.ini.erb'
    variables node['services']['php']
    notifies :restart, 'service[php7.0-fpm]', :delayed
  end
end
