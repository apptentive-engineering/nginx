#
# Cookbook Name:: nginx
# Recipe:: http_limit_req_module
#

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--with-http_limit_req_module"]
