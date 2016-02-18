# ELK Puppet Module

#### Table of Contents
1. [Overview](#overview)
2. [Usage](#usage)

## Overview
This module is a wrapper for the following modules to get the ELK stack up and running:
  * https://forge.puppetlabs.com/elasticsearch/elasticsearch
  * https://forge.puppetlabs.com/elasticsearch/logstash
  * https://forge.puppetlabs.com/lesaux/kibana4

The module takes in the urls for elasticsearch, logstash, and kibana4 from the params.pp file.

Note: This module doesnt change the default cluster name of Elasticsearch

## Usage
In your site.pp
```puppet
node 'example.com'{
  class { 'elk':
    es_ip              => '127.0.0.1',
    es_cluster         => 'clustername',
    es_node            => 'clusternode',
    es_package_url     => 'http://url.to.elasticsearch.deb',
    ls_package_url     => 'http://url.to.logstash.deb',
    kibana_package_url => 'http://url.to.kibana.tar',
    listen_ip          => '127.0.0.1',
  }
}
```