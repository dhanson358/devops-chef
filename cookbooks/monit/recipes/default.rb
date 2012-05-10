package "monit" do
  action :install
end

cookbook_file "/etc/default/monit" do
  owner "root"
  group "root"
  mode 0755
end

template "/etc/monit.conf" do
  owner "root"
  group "root"
  mode 0700
  source 'monitrc.conf.erb'
end

template "/etc/monit/monitrc" do
  owner "root"
  group "root"
  mode 0700
  source 'monitrc.conf.erb'
end

node[:monit][:services].each do |servicename,metadata|
  
  template "/etc/monit/conf.d/"+servicename+".conf" do
    owner "root"
    group "root"
    mode 0700
    variables ({
      :service_name => servicename,
      :metadata => metadata
    })
    source 'monitservice.conf.erb'
  end
  
end

directory "/var/monit" do
  owner "root"
  group "root"
  mode  0700
end

execute "restart-monit" do
  command "/usr/sbin/monit"
  action :nothing
end