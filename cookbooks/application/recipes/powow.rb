include_recipe "passenger-nginx"
include_recipe "application::default"

app_name = "powow-ruby"

app_path = node[:application][:root_path] + '/' + app_name

directories = [app_path, node[:application][:root_path]+'/deploy/'+app_name+'/releases', node[:application][:root_path]+'/deploy/'+app_name+'/log', node[:application][:root_path]+'/deploy/'+app_name+'/shared']

directories.each do |d|
  directory d do
    owner "root"
    group "root"
    mode "0777"
    recursive true
    action :create
  end
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
  action [:start, :restart]
end