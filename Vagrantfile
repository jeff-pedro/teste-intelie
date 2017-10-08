Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64" 
	
	# DEFININDO SERVIDOR DE BANCO DE DADOS 'master'
	config.vm.define :dbmaster do |dbmaster_config|
		dbmaster_config.vm.hostname = "dbmaster.local"
		dbmaster_config.vm.network "private_network", ip: "192.168.10.50"
		dbmaster_config.vm.provision :chef_apply do |chef|
			chef.recipe = File.read("./chef-repo/db_config.rb")
		end  
		dbmaster_config.vm.provision "shell", path: "scripts/replication_master.sh"
	end

	# DEFININDO SERVIDOR DE BANCO DE DADOS 'slave'
	config.vm.define :dbslave do |dbslave_config|
		dbslave_config.vm.hostname = "dbslave.local"
		dbslave_config.vm.network "private_network", ip: "192.168.10.51"
		dbslave_config.vm.provision :chef_apply do |chef|
			chef.recipe = File.read("./chef-repo/db_config.rb")
		end
		dbslave_config.vm.provision "shell", path: "scripts/replication_slave.sh" 
	end
end
