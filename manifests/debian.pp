class elk::debian (
  $es_ip              = $elk::params::es_ip,
  $es_cluster         = $elk::params::es_cluster,
  $es_node            = $elk::params::es_node,
  $es_package_url     = $elk::params::es_package_url,
  $ls_package_url     = $elk::params::ls_package_url,
  $kibana_package_url = $elk::params::kibana_package_url,
  $es_config_dir      = $elk::params::es_config_dir,
  $listen_ip          = $elk::params::listen_ip,) inherits elk::params {
  if $::hardwaremodel == 'x86_64' {
    # set exec path so sysctl works
    Exec {
      path => '/usr/bin:/usr/sbin:/sbin:/bin' }

    # Disable ipv6
    sysctl::value { "net.ipv6.conf.all.disable_ipv6": value => "1" } ->
    sysctl::value { "net.ipv6.conf.default.disable_ipv6": value => "1" } ->
    sysctl::value { "net.ipv6.conf.lo.disable_ipv6": value => "1" } ->
    anchor { 'elk::debian::begin': }

    class { 'elasticsearch':
      package_url  => $es_package_url,
      java_install => true,
    }

    elasticsearch::instance { $es_node: configdir => $es_config_dir }

    anchor { 'elk::debian::end': }

    # logstash install
    class { 'logstash':
      package_url => $ls_package_url,
    }

    # kibana 4 install
    class { '::kibana4':
      package_provider  => 'package',
      package_name      => 'kibana',
      package_ensure    => '4.4.1',
      manage_user       => false,
      manage_init_file  => false,
      service_name      => 'kibana',
      kibana4_user      => 'kibana',
      kibana4_group     => 'kibana',
      use_official_repo => true,
      repo_version      => '4.4',
      config            => {
        'port'              => 5601,
        'host'              => '0.0.0.0',
        'elasticsearch_url' => 'http://localhost:9200',
      }
    }

    file { "/etc/logstash/conf.d/logstash.conf":
      ensure  => present,
      content => template('elk/logstash.conf.erb'),
    }
    Anchor['elk::debian::begin'] -> Class['kibana4'] -> Class['logstash'] -> Anchor['elk::debian::end']
  } else {
    fail("The ELK Module is only supported on 64bit operating systems")
  }
}
