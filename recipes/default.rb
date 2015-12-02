version = node['formatron_topbeat']['version']

interval = node['formatron_topbeat']['interval']
procs = node['formatron_topbeat']['procs']
stats_system = node['formatron_topbeat']['stats_system']
stats_proc = node['formatron_topbeat']['stats_proc']
stats_filesystem = node['formatron_topbeat']['stats_filesystem']
hostname = node['formatron_topbeat']['logstash']['hostname']
port = node['formatron_topbeat']['logstash']['port']

include_recipe 'formatron_beats::default'

package 'topbeat' do
  version version
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
