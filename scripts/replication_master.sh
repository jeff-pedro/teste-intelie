#!/bin/bash

ARQ_CONFIG_MYSQL=/etc/mysql/my.cnf

#COMENTA PARAMETRO PARA HABILITAR O ACESSO AO SERVIDOR MYSQL POR HOSTS EXTERNOS
sed -ri 's/^(bind-address)/#\1/g' $ARQ_CONFIG_MYSQL

# INCLUI O PARAMETRO server-id e log-bin PARA HABILATA-LO COMO MASTER
cat $ARQ_CONFIG_MYSQL | grep 'server-id=1' >> /dev/null
if [ $? -ne 0 ]
then
        $(sed -i '44i\server-id=1\' $ARQ_CONFIG_MYSQL)
fi

cat $ARQ_CONFIG_MYSQL | grep 'log-bin' >> /dev/null
if [ $? -ne 0 ]
then
        $(sed -i '44i\log-bin=/var/lib/mysql/mysql-bin.log\' $ARQ_CONFIG_MYSQL)
fi

# APLICA PERMISSOES PARA O HOST SLAVE BUSCAR OS DADOS	
mysql -uroot -e "GRANT REPLICATION SLAVE ON *.* TO 'replication'@'192.168.10.51' IDENTIFIED BY 'passreplication';"
mysql -uroot -e "FLUSH PRIVILEGES;"
service mysql restart
