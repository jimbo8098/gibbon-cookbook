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

