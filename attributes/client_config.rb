###
# These attributes are to be adjusted in the policy group accordingly.
###

# Specify Chef Server FQDN & IP
default['bootstrap_a_node']['chef_server']['ipaddress'] = '3.112.236.1'
default['bootstrap_a_node']['chef_server']['fqdn'] = 'ec2-3-112-236-1.ap-northeast-1.compute.amazonaws.com'

# Specify Org name and its key file name
default['bootstrap_a_node']['org_name'] = 'first-org'
default['bootstrap_a_node']['org_validation_key_file'] = 'first-org-validator.pem'

# Specify Policy name & Policy group OR Environment
default['bootstrap_a_node']['policy_name'] = 'web-server'
default['bootstrap_a_node']['policy_group'] = 'staging'

# Specify chef-client version
default['bootstrap_a_node']['chef_client']['version'] = '16.10'

# Specfy interval/splay for `chef-client` daemon
default['chef_client']['interval'] = 60
default['chef_client']['splay'] = 0
