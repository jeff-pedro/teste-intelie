#teste-intelie

O teste consiste na implementação de duas máquinas virtuais com o mysql instalado e configurado com uma database vazia, está configurado a replicação de dados entre esses duas bases como master/slave.

Para o processo foi utilizado Vagrant (provisionamento das VMs), Chef (provisionamento das instalações e configurações) e Shell script Bash (configuração da replicação entre as duas bases).

A replicação acontece através de mudanças de eventos nos log binários, onde o servidor mysql 'master' matem no arquivo mysql-bin.log os registros de comandos executados na base, que por sua vez são capturados pela base do servidor 'slave'.

---- Dados de Acesso ----

servidor master: dbmaster
servidor slave:  dbslave		

database: dbintelie
user: administrator
pass: admin

