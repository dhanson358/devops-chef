default[:passenger][:version] = "3.0.12"
default[:nginx][:source][:url] = "http://nginx.org/download/nginx-"
default[:nginx][:source][:version] = "1.2.0"
default[:nginx][:prefix_dir] = "/usr"
default[:nginx][:base_dir] = "/var/lib/nginx"

# default modules
default[:nginx][:source][:modules][:eval][:name] = "nginx_eval_module-1.0.1"
default[:nginx][:source][:modules][:eval][:src] = "https://s3.amazonaws.com/chef-binaries/nginx_eval_module-1.0.1.tar.gz"

default[:nginx][:source][:modules][:echo][:name] = "echo-nginx-module-0.38rc2"
default[:nginx][:source][:modules][:echo][:src] = "https://s3.amazonaws.com/chef-binaries/echo-nginx-module-0.38rc2.tar.gz"

default[:nginx][:source][:modules][:upstream_fair][:name] = "nginx-upstream-fair-a18b409"
default[:nginx][:source][:modules][:upstream_fair][:src] = "https://s3.amazonaws.com/chef-binaries/nginx-upstream-fair-a18b409.tgz"

default[:nginx][:source][:modules][:memc][:name] = "nginx-memc-0.13rc3"
default[:nginx][:source][:modules][:memc][:src] = "https://s3.amazonaws.com/chef-binaries/nginx-memc-0.13rc3.tar.gz"

default[:nginx][:compile_options]['prefix'] = '/etc/nginx/'
default[:nginx][:compile_options]['sbin-path'] = '/usr/sbin/nginx'
default[:nginx][:compile_options]['conf-path'] = '/etc/nginx/nginx.conf'
default[:nginx][:compile_options]['error-log-path'] = '/var/log/nginx/error.log'
default[:nginx][:compile_options]['pid-path'] = '/run/nginx.pid'
default[:nginx][:compile_options]['lock-path'] = '/run/nginx.lock'
default[:nginx][:compile_options]['http-log-path'] = '/var/log/nginx/access.log'
default[:nginx][:compile_options]['http-client-body-temp-path'] = '/run/shm/nginx_client_temp'
default[:nginx][:compile_options]['http-proxy-temp-path'] = '/run/shm/nginx_proxy_temp'
default[:nginx][:compile_options]['http-fastcgi-temp-path'] = '/run/shm/nginx_fastcgi_temp'
default[:nginx][:compile_options]['http-uwsgi-temp-path'] = '/run/shm/nginx_uwsgi_temp'
default[:nginx][:compile_options]['http-scgi-temp-path'] = '/run/shm/nginx_scgi_temp'
default[:nginx][:compile_options]['user'] = 'www-data'
default[:nginx][:compile_options]['group'] = 'www-data'
default[:nginx][:compile_options]['with-http_realip_module'] = true
default[:nginx][:compile_options]['with-http_addition_module'] = true
default[:nginx][:compile_options]['with-http_sub_module'] = true
default[:nginx][:compile_options]['with-http_stub_status_module'] = true
default[:nginx][:compile_options]['with-http_ssl_module'] = true
default[:nginx][:compile_options]['with-http_gzip_static_module'] = true
default[:nginx][:compile_options]['with-file-aio'] = true

default[:nginx][:conf][:worker_processes] = 1
default[:nginx][:conf][:worker_connections] = 1024

default[:nginx][:conf][:user] = "nobody"

default[:nginx][:conf][:http][:include] = 'mime.types'
default[:nginx][:conf][:http][:default_type] = 'application/octet-stream'
default[:nginx][:conf][:http][:sendfile] = "on"
default[:nginx][:conf][:http][:tcp_nopush] = "on"
default[:nginx][:conf][:http][:keepalive_timeout] = 65
default[:nginx][:conf][:http][:gzip] = "on"
