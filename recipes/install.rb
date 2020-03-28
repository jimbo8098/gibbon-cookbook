remote_file "gibbon-#{node['gibbon']['version']}.zip" do
  source "https://github.com/GibbonEdu/core/releases#{node['gibbon']['version']}"
  action :create
end

archive_file "gibbon-#{node['gibbon']['version']}.zip" do
  destination "gibbon-#{node['gibbon']['version']}/"
  action :extract
end



