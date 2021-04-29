# InSpec test for recipe node_setup::client_setup.rb

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe file('/etc/chef/client.rb') do
  its('content') { should match /chef_license "accept"/ }
  its('content') { should match /chef_server_url/ }
  its('content') { should match /policy_group "staging"/ }
  its('content') { should match /policy_name "web-server"/ }
  its('content') { should match /log_location STDOUT/ }
  its('content') { should match %r{validation_key "/etc/chef/first-org-validator.pem"} }
  its('content') { should match %r{trusted_certs_dir "/etc/chef/trusted_certs"} }
end

describe file('/etc/chef/client.pem') do
  it { should exist }
end

describe service('chef-client') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
