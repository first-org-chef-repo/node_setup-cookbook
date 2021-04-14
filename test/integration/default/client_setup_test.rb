# InSpec test for recipe bootstrap_a_node::client_setup.rb

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

describe file('/etc/chef/first-org-validator.pem') do
  it { should exist }
end

describe directory('/etc/chef/trusted_certs') do
  it { should exist }
end

describe service('chef-client') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
