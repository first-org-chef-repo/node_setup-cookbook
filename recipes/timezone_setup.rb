#
# Cookbook:: node_setup
# Recipe:: timezone_setup.rb
#
# Copyright:: 2021, The Authors, All Rights Reserved.

timezone "Set TZ to #{node['node_setup']['timezone']}" do
  timezone "#{node['node_setup']['timezone']}"
end
