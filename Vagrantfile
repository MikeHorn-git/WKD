# frozen_string_literal: true

Vagrant.configure('2') do |config|
  ENV['LC_ALL'] = 'en_US.UTF-8'
  config.vm.box = 'gusztavvargadr/windows-11'
  config.vm.box_version = '2402.0.2503'

  config.vm.boot_timeout = 1000
  config.vm.hostname = 'host'
  config.vm.network 'private_network', type: 'dhcp'

  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder './fuzzer', '/fuzzer'

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '4096'
    vb.cpus = 4
    vb.name = 'KernelWindows'
    vb.gui = false
    vb.check_guest_additions = false
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
  end

  config.vm.provision 'shell', path: './scripts/ps1/setup.ps1'
  config.vm.provision 'shell', path: './scripts/ps1/winget.ps1'
  config.vm.provision :reload
  config.vm.provision 'shell', path: './scripts/ps1/tools.ps1'
  config.vm.provision :reload

  if ENV['VAGRANT_FUZZER'] == 'true'
    config.vm.provision 'shell', path: './scripts/ps1/mount.ps1'
    config.vm.provision 'shell', path: './scripts/bat/hevd.bat'
    config.vm.provision :reload
    config.vm.provision 'shell', path: './scripts/bat/start.bat'
  end
end
