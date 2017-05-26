#
# Cookbook Name:: php_box
# Recipe:: default
#
# Copyright 2017, AMA Team
#
# All rights reserved - Do Not Redistribute
#

apt_update

directory '/var/log/application' do
  recursive true
  owner 'www-data'
  group 'www-data'
end

include_recipe '::mailhog'
include_recipe '::mysql'
include_recipe '::pma'
include_recipe '::php'
include_recipe '::nginx'
