# dtag-mta

Puppet module to set up a mail transfer agent for DTAG-Cloud platform.

## Requirements

You will require puppet modules as described in `vagrant/Puppetfile`, or more specifically with version numbers in `vagrant/Puppetfile.lock`.

## Configuration

    class { 'dtag-mta':
      certificate     => undef,       # a certificate to be used for TLS
      key             => undef,       # a key for TLS
                                      # you need to set both to use TLS
      host            => '0.0.0.0',   # which address to listen on
      generic_map     => '',          # provide contents for the generic map file
      ratelimit       => true,        # whether to use ratelimiting
    }

## Vagrant

You may try a standalone installation of this module via Vagrant. For this you need:

* vagrant
* librarian-puppet

In order to run it:

    cd vagrant/
    librarian-puppet install 
    vagrant up

This setup can support client-side certificates. If you want to use it, make sure you have a file `cert.pem` in your `vagrant` folder and uncomment these lines in `vagrant/manifests/default.pp`:

    # use dtagcloud postfix to configure postfix
    class { 'dtagcloud_postfix':
      certificate => '/vagrant/cert.pem',
      key => '/vagrant/cert.pem',
    }
