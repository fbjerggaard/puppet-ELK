class elk::params {
  $es_ip              = 'localhost'
  $es_cluster         = 'testcluster'
  $es_node            = 'testNode'
  $es_package_url     = 'https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.2.0/elasticsearch-2.2.0.deb'
  $ls_package_url     = 'https://download.elastic.co/logstash/logstash/packages/debian/logstash_2.2.1-1_all.deb'
  $kibana_package_url = 'https://download.elastic.co/kibana/kibana/kibana-4.4.1-linux-x64.tar.gz'
  $es_config_dir      = '/etc/elasticsearch'
  $listen_ip          = $::ipaddress
}
