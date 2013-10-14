# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  
  # config.vm.box_url = "http://domain.com/path/to/above.box"
  # config.vm.network :forwarded_port, guest: 8080, host: 8080
  
  config.vm.hostname = "mta.local"

  config.vm.provision :shell, inline: [
    'apt-get update',
    'aptitude install -y ruby1.9.3 libaugeas-dev libaugeas-ruby1.9.1 build-essential pkg-config',
    'gem install ruby-augeas'
    ].join(' && ')
  config.vm.provision :puppet do |puppet|
    puppet.module_path = "modules"
  end

end