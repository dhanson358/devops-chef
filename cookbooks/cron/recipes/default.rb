package "cron"

template "/etc/crontab" do
  owner "root"
  group "root"
  mode 0644
end