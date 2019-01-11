Vagrant.configure("2") do |config|
  config.vm.box = "slavrd/nginx64"

  # prort to be used when building and starting the project from source 
  config.vm.network "forwarded_port", guest: 5000, host: 5000

  # ports used when starting different application versions 
  # for blue/green deployment demo
  config.vm.network "forwarded_port", guest: 5002, host: 5002
  config.vm.network "forwarded_port", guest: 5003, host: 5003

  # port used by the nginx load balancer
  config.vm.network "forwarded_port", guest: 80, host: 8080
  
  # basic machine configuration
  config.vm.provision "shell", path: "ops/scripts/provision.sh"

  # deploy 2 different application versoin and start them in parallel
  config.vm.provision "shell", path: "ops/scripts/deploy-apps.sh"

  # direct traffic on nginx to the "blue" application
  config.vm.provision "shell", inline: "pushd /vagrant/ops/scripts; ./switch-nginx-traffic.sh blue; popd"

end
