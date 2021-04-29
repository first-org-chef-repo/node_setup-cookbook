###
# These attributes are to be adjusted in the policy group accordingly.
###

# Specify Chef Server FQDN & IP
default['node_setup']['chef_server']['fqdn'] = 'chef-automate.creationline.com'

# Specify Org name and its key file name
default['node_setup']['org_name'] = 'first-org'
default['node_setup']['org_validation_key_file'] = 'first-org-validator.pem'

# Specify Policy name & Policy group OR Environment
default['node_setup']['policy_name'] = 'web-server'
default['node_setup']['policy_group'] = 'staging'

# Specify chef-client version
default['node_setup']['chef_client']['version'] = '17'
default['node_setup']['chef_client']['channel'] = 'stable'

# Specfy interval/splay for `chef-client` daemon
default['chef_client']['interval'] = 60
default['chef_client']['splay'] = 0
