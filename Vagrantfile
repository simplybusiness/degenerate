# -*- mode: ruby -*-
# vi: set ft=ruby :

REGION="virt"
STAGE="integration"
APP="degenerate"
ROLE="web,app,db"


Vagrant.configure(2) do |config|
  vm = config.vm
  vm.box = "centipede"

  # This is fine for a single VM.  If you are going to add multiple
  # VMs for this app (e.g. if you want to simulate a cluster), make
  # sure each machine has a unique hostname, otherwise the puppet server
  # will get confused

  vm.hostname = "#{APP}-#{STAGE}".gsub(/_/,'-')

  # You may wish to allocate more memory to the guest if the app is
  # quite large

  vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # This causes the machine to check in with your virtualbox
  # puppetmaster when it starts up.  You probably don't want to change
  # these commands unless you know what you're doing

  vm.network "private_network", type: :dhcp , ip: '192.168.30.254', dhcp_ip: '192.168.30.2', dhcp_lower: '192.168.30.6'


  vm.provision :shell, inline: "/usr/local/sbin/make-puppet-csr #{REGION} #{STAGE} #{APP} #{ROLE}"
  vm.provision :shell, inline: "service puppet once --test"
  vm.provision :shell, inline: "service puppet start"
end
