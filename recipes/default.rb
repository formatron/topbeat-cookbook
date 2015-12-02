version = node['formatron_topbeat']['version']
checksum = node['formatron_topbeat']['checksum']
interval = node['formatron_topbeat']['interval']
procs = node['formatron_topbeat']['procs']
stats_system = node['formatron_topbeat']['stats_system']
stats_proc = node['formatron_topbeat']['stats_proc']
stats_filesystem = node['formatron_topbeat']['stats_filesystem']
hostname = node['formatron_topbeat']['logstash']['hostname']
port = node['formatron_topbeat']['logstash']['port']

cache = Chef::Config[:file_cache_path]
deb = File.join cache, 'filebeat.deb' 
deb_url = "https://download.elastic.co/beats/topbeat/topbeat_#{version}_amd64.deb"

remote_file deb do
  source deb_url
  checksum checksum
  notifies :install, 'dpkg_package[topbeat]', :immediately
end

dpkg_package 'topbeat' do
  source deb
  action :nothing
  notifies :restart, 'service[topbeat]', :delayed
end

template '/etc/topbeat/topbeat.yml' do
  variables(
    hostname: hostname,
    port: port,
    interval: interval,
    procs: procs,
    stats_system: stats_system,
    stats_proc: stats_proc,
    stats_filesystem: stats_filesystem
  )
  notifies :restart, 'service[topbeat]', :delayed
end

service 'topbeat' do
  supports status: true, restart: true, reload: false
  action [ :enable, :start ]
end
