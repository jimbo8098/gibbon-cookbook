remote_file "gibbon-#{node['gibbon']['version']}.zip" do
  source "https://github.com/GibbonEdu/core/archive/v#{node['gibbon']['version']}.zip"
  action :create
end

archive_file "gibbon-#{node['gibbon']['version']}.zip" do
  destination "gibbon-#{node['gibbon']['version']}"
  action :extract
end

directory node['gibbon']['gibbon_dir'] do
  recursive true
end

execute node['gibbon']['gibbon_dir'] do
  command "cp -Rf /gibbon-#{node['gibbon']['version']}/core-#{node['gibbon']['version']}/. #{node['gibbon']['gibbon_dir']}"
  creates "#{node['gibbon']['gibbon_dir']}/version.php"
end



