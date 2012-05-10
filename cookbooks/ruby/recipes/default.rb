#
# Cookbook Name:: rbenv
# Recipe:: default

# Make sure that the package list is up to date on Ubuntu/Debian.
include_recipe "apt" if [ 'debian', 'ubuntu' ].member? node[:platform]

# Make sure we have all we need to compile ruby implementations:
package "curl"
package "git-core"
package "libpq-dev"
include_recipe "build-essential"
 
%w(libreadline5-dev zlib1g-dev libssl-dev libxml2-dev libxslt1-dev libmysql-ruby libmysqlclient-dev libopenssl-ruby).each do |pkg|
  package pkg
end
 
bash "cloning rbenv" do
  user node[:rbenv][:user]
  cwd "/home/#{node[:rbenv][:user]}"
  code <<-EOH
    git clone git://github.com/sstephenson/rbenv.git .rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    git clone git://github.com/sstephenson/ruby-build.git    
    cd ruby-build
    sudo ./install.sh
    exec $SHELL
    rbenv install 1.9.2-p290
    rbenv global 1.9.2-p290
  EOH
  not_if { "ruby -v |grep 1.9.2" }
end

