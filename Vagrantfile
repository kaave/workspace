# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.name = ENV['VM_NAME'] || 'workspace'
  config.vm.cpus = ENV['VM_CPUS'] || 2
  config.vm.memory = ENV['VM_MEMORY'] || 4096
  config.vm.synced_folder "./Projects", "/Projects", type: "nfs"
  # rsync version: run vagrant rsync-auto
  # config.vm.synced_folder "./Projects", "/Projects", type: "rsync",
  #   rsync__args: ["--verbose", "--archive", "--delete", "--copy-links", "--times", "-z"],
  #   rsync__exclude: [".git/"]

  config.vm.provision :shell, privileged: false, path: "bootstrap.bash"

  config.vm.provider 'parallels' do |v|
    # v.update_guest_tools = true
  end
end
