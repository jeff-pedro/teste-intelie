<h1> #teste-intelie </h1>

O teste consiste na implementação de duas máquinas virtuais com o mysql instalado e configurado com uma database vazia, está configurado a replicação de dados entre esses duas bases como master/slave.

Para o processo foi utilizado Vagrant (provisionamento das VMs), Chef (provisionamento das instalações e configurações) e Shell script Bash (configuração da replicação entre as duas bases).

A replicação acontece através de mudanças de eventos nos log binários, onde o servidor mysql 'master' matem no arquivo mysql-bin.log os registros de comandos executados na base, que por sua vez são capturados pela base do servidor 'slave'.


<h2>PROCESSO DE CONFIGURAÇÃO DE REPLICAÇÃO MASTER/SLAVE</h2>

<b>CONFIG. MASTER</b>

1 - configurar o arquivo 'my.cnf' incluindo as linhas 'log-bin=/var/lib/mysql/mysql-bin.log' (local de origem dos logs binários) e server-id=1 (configura como master).

2 - reiniciar o serviço e incluir o usuário de replicação no mysql, apenas com acesso para o host do mysql slave.
<br>
<code> 
	GRANT REPLICATION SLAVE ON *.* TO 'replication'@'[host_slave_ip]' IDENTIFIED BY '[password]'
</code>
<br>

<b>CONFIG. SLAVE</b>

1 - configurar o arquivo 'my.cnf' incluindo a linha server-id=2 (configura como slave).

2 - reiniciar o serviço e habilitar a replicação como slave no mysql.
<br>
<code>
	CHANGE MASTER TO
       	MASTER_HOST='[host-master-ip]',
       	MASTER_USER='replication',
       	MASTER_PASSWORD='[password]'
</code>
<br>

3 - habilitar o banco como slave.
<br>
<code>
	START SLAVE
</code>
<br>

OBS.: nos arquivos 'my.cnf' do master e slave, comentar/incluir no parâmentro 'bind-address' os hosts que irão se comunicar.
  

---- <b>Dados de Acesso</b> ----

servidor master: dbmaster <br>
servidor slave:  dbslave <br>		
<br>
database: dbintelie <br>
user: administrator <br>
pass: admin <br>
