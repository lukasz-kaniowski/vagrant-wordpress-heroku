include_recipe "apt"
include_recipe "postgresql::server"
include_recipe "database"

include_recipe "php"
include_recipe "php::module_pgsql"
include_recipe "apache2"
include_recipe "apache2::mod_php5"

conn = {:host => "127.0.0.1", :port => 5432, :username => 'postgres',
    :password => node['postgresql']['password']['postgres']}

user = "wordpress"
pass = "wordpress"
db = "wordpress"

postgresql_database_user user do
  connection conn
  password pass
  action :create
end

postgresql_database db do
  connection conn
  owner user
  action :create
end

#used by wp-config.php, same env in heroku stack
template "/etc/profile.d/wordpress.sh" do
  source "profile_env.erb"
  owner "root"
  mode "0644"
  variables(
      :env_vars => {"DATABASE_URL" => "postgres://#{user}:#{pass}@localhost:5432/#{db}"}
  )
  notifies :reload, resources(:service => "apache2")
end

apache_user = "vagrant"

node.override["apache"]["user"] = apache_user
node.override["apache"]["group"] = apache_user

apache_site "000-default" do
  enable false
end


server_fqdn = node['fqdn']

web_app "wordpress" do
  template "wordpress.conf.erb"
  docroot "/var/www/wordpress"
  server_name server_fqdn
  server_aliases node['fqdn']
end
