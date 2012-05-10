include_recipe "passenger-nginx"
include_recipe "application::default"

app_name = "hvs"

app_path = node[:application][:root_path] + '/' + app_name

directory app_path do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

template "/etc/nginx/sites-enabled/#{app_name}" do
  source    "nginx-site-conf.erb"
  owner     "root"
  group     "root"
  mode      "0755"
  variables(
    :code_path => app_path,
    :environment => node[:application][:environment]
  )
end

service "nginx" do
  action [:start]
end