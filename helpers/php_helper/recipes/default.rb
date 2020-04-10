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
end
