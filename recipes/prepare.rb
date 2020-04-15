apache2_install 'default'

service 'apache2' do
  extend Apache2::Cookbook::Helpers
  service_name lazy { apache_platform_service_name }
  supports restart: true, status: true, reload: true
  action [:start, :enable]
end

node['apache']['modules'].each do |mod|
  apache2_module mod
end

template node['gibbon']['site_name'] do
  extend  Apache2::Cookbook::Helpers
  source "site.conf.erb"
  path "#{apache_dir}/sites-available/#{node['gibbon']['site_name']}.conf"
  variables(
    server_name: node['gibbon']['site_name'],
    document_root: node['gibbon']['gibbon_dir'],
    log_dir: lazy { default_log_dir },
    site_name: node['gibbon']['site_name'],
    port: node['gibbon']['port'],
    ip: node['gibbon']['ip']
  )
end

apache2_site node['gibbon']['site_name']

if node['php']['install_method'] == 'package' then
  if node['platform_family'] == 'rhel' then
    #On RHEL, make sure yum EPEL and REMI are enabled if not compiling from source
    include_recipe 'yum-remi-chef::remi-php73'
    include_recipe 'php'
    package %w(php-gd php-mysql)
    php_pear %w(zip HTTP_Request2 File_Gettext)
  else
    raise "Helper only support RHEL"
  end
else
  include_recipe 'php'
end


mariadb_server_install 'mariadb'
service 'mariadb' do
  action :start
end

database = node['gibbon']['database']

mariadb_database 'gibbon-database' do
  user 'root'
  password node['mariadb']['server_root_password']
  host database['host']
  port database['port']
  database_name database['name']
#  encoding 'utf8'
#  collation 'utf8_general_ci'
  action :create
end

mariadb_user 'gibbon-user' do
  username database['username']
  password database['password']
  host 'localhost'
  database_name database['name']
end


