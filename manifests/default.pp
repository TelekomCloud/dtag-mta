include postfix

# relay configuration
postfix::config { 'relay_domains'      : value  => 'localhost telekom.com telekom.de' }
# tls configuration
postfix::config{ 'smtp_use_tls'        : value => 'yes' }
postfix::config{ 'smtp_tls_cert_file'  : value => '/etc/postfix/b3.pem' }
postfix::config{ 'smtp_tls_key_file'   : value => '/etc/postfix/b3.pem' }
postfix::config{ 'smtp_tls_loglevel'   : value => '1' }
postfix::config{ 'smtpd_tls_cert_file' : value => '/etc/postfix/b3.pem' }
postfix::config{ 'smtpd_tls_key_file'  : value => '/etc/postfix/b3.pem' }
# origin and destination configuration
postfix::config{ 'smtp_generic_maps'   : value => 'hash:/etc/postfix/generic' }

file { "/etc/postfix":
  ensure => directory,
}
->
# generate the generic map db file
file { "/etc/postfix/generic":
#  content => "
#nagios@h2072290.stratoserver.net nagios@b3.internal.app.telekomcloud.com
#@puppetmaster.b3.internal.app.telekomcloud.com   nagios@b3.internal.app.telekomcloud.com
#",
  content => "",
  require => File["/etc/postfix"]
}

exec { "/usr/sbin/postmap /etc/postfix/generic":
  subscribe => File["/etc/postfix/generic"],
  refreshonly => true,
  require => Package['postfix'],
}
