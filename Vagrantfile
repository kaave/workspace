# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.synced_folder "./Projects", "/Projects", type: "nfs"

  config.vm.provision :shell, path: "bootstrap.bash"

  config.vm.provider 'parallels' do |v|
    v.name = 'kaave_workmachine'
    v.cpus = 4
    v.memory = 8192
  end
end
