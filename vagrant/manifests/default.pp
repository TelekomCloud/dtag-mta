# use dtagcloud postfix to configure postfix
class { 'dtag-mta':
#  certificate => '/vagrant/cert.pem',
#  key => '/vagrant/cert.pem',
}

#  generic_map => "
#nagios@h2072290.stratoserver.net nagios@b3.internal.app.telekomcloud.com
#@puppetmaster.b3.internal.app.telekomcloud.com   nagios@b3.internal.app.telekomcloud.com
#",
