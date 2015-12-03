formatron_elasticsearch_template 'topbeat' do
  template JSON.parse(File.read('/etc/topbeat/topbeat.template.json'))
end
