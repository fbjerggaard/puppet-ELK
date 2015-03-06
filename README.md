# ELK Puppet Module

#### Table of Contents
1. [Overview](#overview)
2. [Description](#description)
3. [Dependencies](#dependencies)
4. [Development](#development)

## Overview
This module is a wrapper for the following modules to get the ELK stack up and running
https://forge.puppetlabs.com/elasticsearch/elasticsearch  
https://forge.puppetlabs.com/elasticsearch/logstash  
https://forge.puppetlabs.com/lesaux/kibana4  

The module takes in the urls for elasticsearch, logstash, and kibana4 from the params.pp file.
Currently this module is tested working with the following ELK versions  
Elasticsearch 1.4.4  
Logstash 1.4.2  
Kibana 4.0.1  

Note: This module doesnt change the default cluster name of Elasticsearch

## Dependencies
stdlib  
logstash  
elasticsearch  
file_concat  
puppetlabs_java  

## Development
