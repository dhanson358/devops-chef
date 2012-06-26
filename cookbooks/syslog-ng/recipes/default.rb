package "syslog-ng" do
  action :install
end

directory "/etc/syslog-ng/conf.d" do
	owner "root"
	group "root"
	mode "0755"
	recursive true
	action :create
end


template "/etc/syslog-ng/syslog-ng.conf" do
  owner "root"
  group "root"
  mode 0644
end

node[:syslog][:scripts].each do |scriptname,metadata|
  
  template "/etc/syslog-ng/conf.d/"+scriptname+".conf" do
    owner "root"
    group "root"
    mode 0700
    variables ({
      :name => scriptname,
      :filter => metadata[:filter],
      :destination => metadata[:destination]
    })
    source 'syslog-ng-script.conf.erb'
  end
  
end

service "syslog-ng" do
    supports :status => true, :enable => true, :restart => true, :reload => true
  action [ :enable, :start ]
end