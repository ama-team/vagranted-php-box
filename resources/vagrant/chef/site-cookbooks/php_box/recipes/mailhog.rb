#
# Cookbook Name:: php_box
# Recipe:: mailhog
#
# Copyright 2017, AMA Team
#
# All rights reserved - Do Not Redistribute
#

directory '/var/mailhog' do
  recursive true
end

server_version = node['services']['mailhog']['version']['server']
remote_file '/usr/local/bin/mailhog' do
  source "https://github.com/mailhog/MailHog/releases/download/v#{server_version}/MailHog_linux_386"
  mode '0755'
  notifies :restart, 'service[mailhog]', :delayed
  not_if "[ -x /usr/local/bin/mailhog ] && [ ! -z $(/usr/local/bin/mailhog --version | grep '#{server_version}') ]"
end

sendmail_version = node['services']['mailhog']['version']['sendmail']
remote_file '/usr/sbin/sendmail' do
  source "https://github.com/mailhog/mhsendmail/releases/download/v#{sendmail_version}/mhsendmail_linux_386"
  mode '0755'
end

cookbook_file '/etc/systemd/system/mailhog.service' do
  source 'mailhog/mailhog.service'
  mode '0644'
  notifies :restart, 'service[mailhog]', :delayed
end

service 'mailhog' do
  action :start
end
