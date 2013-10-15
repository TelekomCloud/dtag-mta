# class wrapper around puppet-postfix module
# for dtagcloud
class dtagcloud_postfix(
  $certificate = undef,
  $key = undef,
  $host = '0.0.0.0',
  $generic_map = '',
  ) {

  # initialize postfix puppet module
  class { 'postfix':
    smtp_listen => $host,
  }

  # relay configuration
  postfix::config { 'relay_domains'      : value  => 'localhost telekom.com telekom.de' }
  # origin and destination configuration
  postfix::config{ 'smtp_generic_maps'   : value => 'hash:/etc/postfix/generic' }

  # precursor to postfix configuration
  file { "/etc/postfix":
    ensure => directory,
  }
  ->
  # generate the generic map db file
  file { "/etc/postfix/generic":
    content => $generic_map,
    require => File["/etc/postfix"],
    notify => Service['postfix']
  }

  # generate the portmap databases
  exec { "/usr/sbin/postmap /etc/postfix/generic":
    subscribe => File["/etc/postfix/generic"],
    refreshonly => true,
    require => Package['postfix'],
  }

  # Certificate and key handling
  if $key != undef and $certificate != undef {
    # define where files will be installed
    $cert_path = '/etc/postfix/certificate.pem'
    $key_path = '/etc/postfix/key.pem'

    # copy the certificate and key to the filesystem
    file {'postfix-certificate':
      path    => $cert_path,
      ensure  => present,
      source  => $certificate,
      require => File["/etc/postfix"],
    }
    ->
    file {'postfix-key':
      path    => $key_path,
      ensure  => present,
      source  => $key,
    }

    # tls configuration
    postfix::config{ 'smtp_use_tls'        : value => 'yes' }
    postfix::config{ 'smtp_tls_cert_file'  : value => $cert_path }
    postfix::config{ 'smtp_tls_key_file'   : value => $key_path }
    postfix::config{ 'smtp_tls_loglevel'   : value => '1' }
    postfix::config{ 'smtpd_tls_cert_file' : value => $cert_path }
    postfix::config{ 'smtpd_tls_key_file'  : value => $key_path }
  }

}

# use dtagcloud postfix to configure postfix
class { 'dtagcloud_postfix':
  certificate => '/vagrant/cert.pem',
  key => '/vagrant/cert.pem',
}

#  generic_map => "
#nagios@h2072290.stratoserver.net nagios@b3.internal.app.telekomcloud.com
#@puppetmaster.b3.internal.app.telekomcloud.com   nagios@b3.internal.app.telekomcloud.com
#",
