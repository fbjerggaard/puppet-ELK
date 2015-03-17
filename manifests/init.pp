class elk (
  $es_ip = $elk::params::es_ip,
  $es_cluster = $elk::params::es_cluster,
  $es_node = $elk::params::es_node,
  $es_package_url = $elk::params::es_package_url,
  $ls_package_url = $elk::params::ls_package_url,
  $kibana_package_url = $elk::params::kibana_package_url,
  $listen_ip = $elk::params::listen_ip,
) inherits elk::params {
  case $::osfamily {
    'Debian': {include elk::debian}
    default: {fail("The ELK Module is only tested on Debian based OS's")}
  }
}
