# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "web" do |web|
    config.vm.host_name = "web"
  end

  config.vm.box = "centos7.box"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false 
    vb.memory = "1024"
  end

  config.vm.network "public_network", bridge: "en0: eth"
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/playbook.yml"
  end

end
