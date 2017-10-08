#!/bin/bash

ARQ_CONFIG_MYSQL=/etc/mysql/my.cnf

# COMENTA PARA HABILITAR O ACESSO AO SERVIDOR MYSQL POR HOSTS EXTERNOS
sed -ri 's/^(bind-address)/#\1/g' $ARQ_CONFIG_MYSQL


# INCLUI O PARAMETRO server-id PARA HABILATA-LO COMO SLAVE
cat $ARQ_CONFIG_MYSQL | grep 'server-id=2' >> /dev/null
if [ $? -ne 0 ]
then
	$(sed -i '44i\server-id=2\' $ARQ_CONFIG_MYSQL)
fi


# CONFIGURA O BD PARA SER SLAVE
mysql -uroot -e "STOP SLAVE;"
if [ $? -eq 0 ]
then
	mysql -uroot -e "CHANGE MASTER TO MASTER_HOST='192.168.10.50', MASTER_USER='replication', MASTER_PASSWORD='passreplication';"
	mysql -uroot -e "START SLAVE;"
fi

service mysql restart

