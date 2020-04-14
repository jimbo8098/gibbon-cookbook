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

puts node['gibbon'].inspect
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
