# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Common
  config.vm.box = "bento/ubuntu-18.04"

  # Synced folder
  config.vm.synced_folder "./Projects", "/Projects", type: "nfs"
  # rsync version: run vagrant rsync-auto
  # config.vm.synced_folder "./Projects", "/Projects", type: "rsync",
  #   rsync__args: ["--verbose", "--archive", "--delete", "--copy-links", "--times", "-z"],
  #   rsync__exclude: [".git/"]

  # Network
  # config.vm.network "forwarded_port", guest: 80, host: 10080
  # config.vm.network "forwarded_port", guest: 443, host: 10443
  # config.vm.network "forwarded_port", guest: 3000, host: 13000

  # Provision
  config.vm.provision :shell, privileged: false, path: "bootstrap.bash"

  # for Parallels
  config.vm.provider 'parallels' do |v|
    # v.update_guest_tools = true

    v.name = ENV['VM_NAME'] || 'workspace'
    v.cpus = ENV['VM_CPUS'] || 2
    v.memory = ENV['VM_MEMORY'] || 4096
  end
end
