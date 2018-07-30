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

end
