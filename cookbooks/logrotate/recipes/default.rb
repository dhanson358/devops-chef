package "logrotate" do
  action :upgrade
end

node[:logrotate][:services].each do |s|
  cookbook_file "/etc/logrotate.d/#{s}" do
    source s
    mode "0644"
    owner "root"
    group "root"
    backup false
  end
end