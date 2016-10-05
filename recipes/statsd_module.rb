#
# Cookbook Name:: nginx
# Recipe:: statsd_module
#

src_filename = ::File.basename(node['nginx']['statsd']['url'])
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"
extract_path = "#{Chef::Config['file_cache_path']}/nginx_statsd-#{node['nginx']['statsd']['version']}"

remote_file src_filepath do
  source   node['nginx']['statsd']['url']
  owner    'root'
  group    node['root_group']
  mode     '0644'
  not_if { ::File.exist?(src_filepath) }
end

bash 'extract_statsd' do
  cwd  ::File.dirname(src_filepath)
  code <<-EOH
    mkdir -p #{extract_path}
    tar xzf #{src_filename} -C #{extract_path}
    mv #{extract_path}/*/* #{extract_path}/
  EOH
  not_if { ::File.exist?(extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{extract_path}"]
