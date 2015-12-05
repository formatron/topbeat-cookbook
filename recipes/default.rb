version = node['formatron_topbeat']['version']

enabled = node['formatron_topbeat']['enabled']

interval = node['formatron_topbeat']['interval']
procs = node['formatron_topbeat']['procs']
stats_system = node['formatron_topbeat']['stats_system']
stats_proc = node['formatron_topbeat']['stats_proc']
stats_filesystem = node['formatron_topbeat']['stats_filesystem']

host = node['formatron_topbeat']['logstash']['host']
port = node['formatron_topbeat']['logstash']['port']

include_recipe 'formatron_beats::default'

package 'topbeat' do
  version version
end

template '/etc/topbeat/topbeat.yml' do
  variables(
    host: host,
    port: port,
    interval: interval,
    procs: procs,
    stats_system: stats_system,
    stats_proc: stats_proc,
    stats_filesystem: stats_filesystem
  )
  notifies :restart, 'service[topbeat]', :delayed if enabled
end

service 'topbeat' do
  supports status: true, restart: true, reload: false
  action [ :enable, :start ] if enabled
  action [ :disable, :stop ] unless enabled
end
