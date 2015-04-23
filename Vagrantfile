# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
SWARMIP1 = "192.168.200.3"
SWARMIP2 = "192.168.200.4"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "swarm01" do |swarm01|
    swarm01.vm.box = "ubuntu/trusty64"
    swarm01.vm.network "private_network", ip: SWARMIP1
    swarm01.vm.provision "shell", inline: 'echo "MYIP=' + SWARMIP1 + '" >> /etc/environment'
    swarm01.vm.provision "shell", inline: 'echo "ANIP=' + SWARMIP2 + '" >> /etc/environment'
    swarm01.vm.provision :shell, path: "swarm/bootstrap.sh"
    swarm01.vm.provision "shell", path: "swarm/restart.sh",
      run: "always"
    swarm01.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end

  config.vm.define "swarm02" do |swarm02|
    swarm02.vm.box = "ubuntu/trusty64"
    swarm02.vm.network "private_network", ip: SWARMIP2
    swarm02.vm.provision "shell", inline: 'echo "MYIP=' + SWARMIP2 + '" >> /etc/environment'
    swarm02.vm.provision "shell", inline: 'echo "ANIP=' + SWARMIP1 + '" >> /etc/environment'
    swarm02.vm.provision :shell, path: "swarm/bootstrap.sh"
    swarm02.vm.provision "shell", path: "swarm/restart.sh",
      run: "always"
    swarm02.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end
end
