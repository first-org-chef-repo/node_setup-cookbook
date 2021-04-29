#
# Cookbook:: node_setup
# Recipe:: client_setup.rb
#
# Copyright:: 2021, The Authors, All Rights Reserved.

###########
# Setup client.rb with Chef Server access credentials
###########

chef_client_config 'client.rb' do
  chef_server_url "https://#{node['node_setup']['chef_server']['fqdn']}/organizations/#{node['node_setup']['org_name']}"
  chef_license 'accept'
  log_location 'STDOUT'
  policy_name "#{node['node_setup']['policy_name']}"
  policy_group "#{node['node_setup']['policy_group']}"
  additional_config "validation_key \"/etc/chef/#{node['node_setup']['org_validation_key_file']}\"\ntrusted_certs_dir \"/etc/chef/trusted_certs\""
end

cookbook_file "Place validator key for Org:#{node['node_setup']['org_name']}" do
  not_if { ::File.exist?('/etc/chef/client.pem') }
  source "#{node['node_setup']['org_validation_key_file']}" # Watch out for the file name
  mode '0755'
  owner 'root'
  path "/etc/chef/#{node['node_setup']['org_validation_key_file']}" # Watch out for the file name
  sensitive
end

file 'Delete org validator key' do
  only_if { ::File.exist?('/etc/chef/client.pem') }
  path "/etc/chef/#{node['node_setup']['org_validation_key_file']}"
  action :delete
end

###########
# Control chef-client version with `chef_client_updater` cookbook 'https://github.com/chef-cookbooks/chef_client_updater'
###########

chef_client_updater "up or down grade Chef Infra version to #{node['node_setup']['chef_client']['version']}" do
  version "#{node['node_setup']['chef_client']['version']}"
  channel "#{node['node_setup']['chef_client']['channel']}"
  post_install_action 'exec'
end

###########
# Run the initial Chef Client check-in to generate `client.pem`. If `client.pem` already exists, no CCR wil be executed.
# `--why-run` is used as the initial CCR is just for `client.pem` generation. This way `chef-run` finishes a lot faster.
###########

ruby_block 'Run chef-client' do
  not_if { ::File.exist?('/etc/chef/client.pem') }
  block do
    system '/opt/chef/bin/chef-client'
  end
end

ruby_block 'Checking if initial CCR succesfully completed...' do
  notifies :run, 'ruby_block[Run chef-client]', :before
  not_if { ::File.exist?('/etc/chef/client.pem') }
  block do
    raise "\n [WARN] No client.pem found and no trace of check-in. You might want to login the node and run chef-client manually and check its status. Possibly chef-client failed to check-in Chef Server for some reason."
  end
end
