# service['apache2'] is defined in the apache2_default_install resource but other resources are currently unable to reference it.  To work around this issue, define the following helper in your cookbook:

apache2_install 'default_install'

#service 'apache2' do
#  extend Apache2::Cookbook::Helpers
#  service_name lazy { apache_platform_service_name }
#  supports restart: true, status: true, reload: true
#  action :nothing
#end
#
#apache2_install 'default_install'
#
#site 'gibbon' do
#  default_site_name 'my_site'
#  template_cookbook 'my_cookbook'
#  port '443'
#  template_source 'my_site.conf.erb'
#  action :enable
#end
