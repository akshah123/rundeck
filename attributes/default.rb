default['rundeck'] = {}
default['rundeck']['configdir'] = "/etc/rundeck"
default['rundeck']['basedir'] = "/var/lib/rundeck"
default['rundeck']['datadir'] = "/var/rundeck"
default['rundeck']['deb']['package'] = "rundeck-2.2.1-1-GA.deb"
default['rundeck']['deb']['options'] = false #--force-confdef --force-confold
default['rundeck']['url'] = "http://download.rundeck.org/deb/#{node['rundeck']['deb']['package']}"
default['rundeck']['checksum'] = "816b96bf4545bd831c87d5ef1953770a0e705192d4c96bc4907f483c4558f269"
default['rundeck']['port'] = 4440
default['rundeck']['jaas'] = "internal"
default['rundeck']['default_role'] = "user"
default['rundeck']['hostname'] = "rundeck.#{node['domain']}"
default['rundeck']['email'] = "rundeck@#{node['domain']}"
default['rundeck']['restart_on_config_change'] = false
default['rundeck']['apache-template']['cookbook'] = "rundeck"
default['rundeck']['log_dir'] = "/var/log/chef-rundeck"
default['rundeck']['server_url'] = node['rundeck']['hostname']
default['rundeck']['log_level'] = "DEBUG" #ERR,WARN,INFO,VERBOSE,DEBUG
default['rundeck']['rss_enabled'] = true

#databag name configuration
default['rundeck']['rundeck_databag_secure'] = "secure"
default['rundeck']['rundeck_databag'] = "rundeck"
default['rundeck']['rundeck_projects_databag'] = "rundeck_projects"

# chef-rundeck
if node['platform'] == 'ubuntu' || node['platform_family'] == 'rhel'
  default['rundeck']['chef_rundeck_use_upstart'] = true
else
  default['rundeck']['chef_rundeck_use_upstart'] = false
end

default['rundeck']['chef_rundeck_gem'] = nil
default['rundeck']['chef_rundeck_port'] = 9980
default['rundeck']['chef_rundeck_host'] = "0.0.0.0"
default['rundeck']['chef_rundeck_partial_search'] = false
default['rundeck']['user'] = "rundeck"
default['rundeck']['group'] = node['rundeck']['user']
default['rundeck']['user_home'] = "/home/rundeck"
default['rundeck']['chef_config'] = "/etc/chef/rundeck.rb"
default['rundeck']['chef_client_name'] = "chef-rundeck"
default['rundeck']['chef_rundeck_url'] = "http://chef.#{node['domain']}:#{node['rundeck']['chef_rundeck_port']}"
default['rundeck']['chef_webui_url'] = "https://chef.#{node['domain']}"
default['rundeck']['chef_url'] = "https://chef.#{node['domain']}"
default['rundeck']['project_config'] = "/etc/chef/chef-rundeck.json"

# SMTP settings for rundeck notification emails
default['rundeck']['mail']['enable'] = false
default['rundeck']['mail']['host'] = "localhost"
default['rundeck']['mail']['port'] = "25"
default['rundeck']['mail']['username'] = ""
default['rundeck']['mail']['password'] = ""

#   If you want to use encrypted databags for your windows password and/or public/private key pairs generate a secret using:
#     'openssl rand -base64 512 | tr -d '\r\n' > rundeck_secret'
#   Distrubute to all sytems that will work with rundeck via a recipe and set the path to that file in the following attribute
#
default['rundeck']['secret_file'] = nil

# External Database properties
default['rundeck']['rdbms']['enable'] = "false"
default['rundeck']['rdbms']['type'] = "mysql"
default['rundeck']['rdbms']['location'] = "someIPorFQDN"
default['rundeck']['rdbms']['dbname'] = "rundeckdb"
default['rundeck']['rdbms']['dbuser'] = "rundeckdb"
default['rundeck']['rdbms']['dbpassword'] = "Chang3ME"
default['rundeck']['rdbms']['dialect'] = "Oracle10gDialect"
default['rundeck']['rdbms']['port'] = "3306"

# Windows Properties
default['rundeck']['windows']['group'] = 'Administrators'
default['rundeck']['windows']['user'] = node['rundeck']['user']
default['rundeck']['windows']['password'] = nil
default['rundeck']['windows']['winrm_auth_type'] = 'basic'
default['rundeck']['windows']['winrm_cert_trust'] = 'all'
default['rundeck']['windows']['winrm_hostname_trust'] = 'all'
default['rundeck']['windows']['winrm_protocol'] = 'https'

# LDAP Properties
default['rundeck']['ldap']['provider'] = "ldap://servername:389"
default['rundeck']['ldap']['binddn'] = "CN=binddn,dc=domain,dc=com"
default['rundeck']['ldap']['bindpwd'] = "BINDPWD"
default['rundeck']['ldap']['authenticationmethod'] = "simple"
default['rundeck']['ldap']['forcebindinglogin'] = "true"
default['rundeck']['ldap']['userbasedn'] = "ou=Users,dc=domain,dc=com"
default['rundeck']['ldap']['userrdnattribute'] = "cn"
default['rundeck']['ldap']['useridattribute'] = "uid"
default['rundeck']['ldap']['userpasswordattribute'] = "userPassword"
default['rundeck']['ldap']['userobjectclass'] = "inetOrgPerson"
default['rundeck']['ldap']['rolebasedn'] = "ou=Groups,dc=domain,dc=com"
default['rundeck']['ldap']['rolenameattribute'] = "cn"
default['rundeck']['ldap']['rolememberattribute'] = "uniqueMember"
default['rundeck']['ldap']['roleusernamememberattribute'] = nil # "memberUid"
default['rundeck']['ldap']['roleobjectclass'] = "groupOfUniqueNames"
default['rundeck']['ldap']['roleprefix'] = "rundeck-"
default['rundeck']['ldap']['cachedurationmillis'] = "300000"
default['rundeck']['ldap']['reportstatistics'] = "true"