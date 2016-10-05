#
# Cookbook Name:: nginx
# Recipe:: statsd_module
#
default['nginx']['statsd']['version'] = '0.0.1'
default['nginx']['statsd']['url']     = "https://github.com/zebrafishlabs/nginx-statsd/archive/#{node['nginx']['statsd']['version']}.tar.gz"
