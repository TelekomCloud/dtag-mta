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
    'update-alternatives --set ruby /usr/bin/ruby1.9.1',
    'update-alternatives --set gem /usr/bin/gem1.9.1',
    'export GEM_HOME=/var/lib/gems/1.9.1',
    'export GEM_PATH=/var/lib/gems/1.9.1',
    'export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/lib/gems/1.9.1/bin',
    'gem install ruby-augeas puppet --no-ri --no-rdoc'
    ].join(' && ')
  config.vm.provision :puppet do |puppet|
    puppet.module_path = "modules"
  end

end