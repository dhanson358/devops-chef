#
# Author::  Anthony Goddard (<anthony@anthonygoddard.com>)
# Modified by:: David Hanson (<david@dhanson.org>)
# Cookbook Name:: nginx-passenger
# Recipe:: default
#
# Copyright 2011, Woods Hole Marine Biological Laboratory
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# 
#

package "libcurl4-openssl-dev"

gem_package "passenger" do
  action :install
end

nginx_src = "/tmp/nginx-#{node[:nginx][:source][:version]}"

# download nginx source
remote_file "#{nginx_src}.tar.gz" do
  source "#{node[:nginx][:source][:url]}#{node[:nginx][:source][:version]}.tar.gz"
end

# extract source
execute "extract nginx" do
  command "tar -C /tmp -xzf #{nginx_src}.tar.gz"
  not_if { File.exists?(nginx_src) }
end


node[:nginx][:source][:modules].each do |k,nmodule|

  # download module source
  remote_file "/tmp/#{nmodule[:name]}.tar.gz" do
    source "#{nmodule[:src]}"
  end

  # extract module source
  execute "extract nginx #{nmodule[:name]} module" do
    command "tar -C /tmp -xzf /tmp/#{nmodule[:name]}.tar.gz"
    not_if { File.exists?("/tmp/#{nmodule[:name]}") }
  end

end

execute "compile nginx with passenger" do
  compile_options = Array.new
  node[:nginx][:compile_options].each do |option,value|
    value === true ? compile_options << "--#{option}" : compile_options << "--#{option}=#{value}"
  end
  node[:nginx][:source][:modules].each do |name,nmodule|
    compile_options << "--add-module=/tmp/#{nmodule[:name]}"
  end
  command "export PATH=/usr/local/rvm/gems/ruby-1.9.3-p125/bin:/usr/local/rvm/gems/ruby-1.9.3-p125@global/bin:/usr/local/rvm/rubies/ruby-1.9.3-p125/bin:/usr/local/rvm/bin:$PATH && passenger-install-nginx-module --auto --prefix=#{node[:nginx][:prefix_dir]} --nginx-source-dir=#{nginx_src} --extra-configure-flags=\"#{compile_options.join(" ")}\""
  not_if "nginx -V 2>&1 |grep passenger-#{node[:passenger][:version]}"
end

directory node[:nginx][:base_dir] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

directory "/run/shm" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

directory "/etc/nginx/sites-enabled" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

# write the init script
template "/etc/init.d/nginx" do
  source "init.erb"
  mode '0755'
  owner 'root'
  group 'root'
end

# write the init script
template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  mode '0755'
  owner 'root'
  group 'root'
end