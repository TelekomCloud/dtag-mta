# Puppet Postfix Vagrant

Goal: have a small isolated vagrant environment that creates a mail-relay for testing purposes. We can verify our configuration of postfix and try out modules here quickly.

## Requirements

* vagrant
* librarian-puppet

## Installation

    librarian-puppet install 
    vagrant up

This setup can support client-side certificates. If you want to use it, uncomment the lines:

    # use dtagcloud postfix to configure postfix
    class { 'dtagcloud_postfix':
      certificate => '/vagrant/cert.pem',
      key => '/vagrant/cert.pem',
    }
