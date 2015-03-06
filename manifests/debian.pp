class elk::debian (
  $es_ip = $elk::params::es_ip,
  $es_cluster = $elk::params::es_cluster,
  $es_node = $elk::params::es_node,
  $es_package_url = $elk::params::es_package_url,
  $ls_package_url = $elk::params::ls_package_url,
  $kibana_package_url = $elk::params::kibana_package_url,
  $es_config_dir = $elk::params::es_config_dir,
) inherits elk::params {

  if $::hardwaremodel == 'x86_64'{
    #set exec path so sysctl works
    Exec {path => '/usr/bin:/usr/sbin:/sbin:/bin'}

    # Disable ipv6
    sysctl::value { "net.ipv6.conf.all.disable_ipv6": value => "1" }->
    sysctl::value { "net.ipv6.conf.default.disable_ipv6": value => "1" }->
    sysctl::value { "net.ipv6.conf.lo.disable_ipv6": value => "1" }->

    anchor { 'elk::debian::begin': }
    class { 'elasticsearch':
      package_url  => $es_package_url,
      java_install => true,
    }
    elasticsearch::instance { $es_node:
      configdir => $es_config_dir
    }
    anchor { 'elk::debian::end': }
    # logstash install
    class { 'logstash':
      package_url => $ls_package_url,
    }
    # kibana 4 install
    class { '::kibana4':
      package_download_url => $kibana_package_url,
      package_provider     => 'archive',
      manage_user          => true,
      kibana4_user         => kibana4,
      kibana4_group        => kibana4,
      kibana4_gid          => 200,
      kibana4_uid          => 200,
  }
  Anchor['elk::debian::end'] Class['kibana4'] -> Class['logstash'] ->Anchor['elk::debian::begin'] ->
  else {
    fail("The ELK Module is only supported on 64 OS's")
  }
}
