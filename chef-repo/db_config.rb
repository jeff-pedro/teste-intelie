execute 'update' do
	command '/usr/bin/apt-get update'
end

package 'mysql-server' 

service 'mysql' do 
	supports :status => true
	action [ :enable, :start ]
end

execute 'dbintelie' do
	command '/usr/bin/mysqladmin -uroot create dbintelie'
end 

execute 'mysql-password' do
	command "mysql -uroot -e \"GRANT ALL PRIVILEGES ON * TO 'administrator'@'%' IDENTIFIED BY 'admin';\" dbintelie"
end
