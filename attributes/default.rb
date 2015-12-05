default['formatron_topbeat']['version'] = nil

default['formatron_topbeat']['enabled'] = true

default['formatron_topbeat']['interval'] = 10
default['formatron_topbeat']['procs'] = ['.*']
default['formatron_topbeat']['stats_system'] = true
default['formatron_topbeat']['stats_proc'] = true
default['formatron_topbeat']['stats_filesystem'] = true

default['formatron_topbeat']['logstash']['host'] = 'localhost'
default['formatron_topbeat']['logstash']['port'] = 5044
