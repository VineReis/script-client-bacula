#!/bin/bash
# CRIAÇÃO: VINICIUS REIS
# DATA DE CRIAÇÃO: 12/08/2020
# DATA DE MODIFICAÇÃO: 13/10/2020
# SCRIPT PARA INSTALAÇÃO DE CLIENT-BACULA

# CRIANDO PASTA PARA BAIXAR O BACULA

mkdir /home/suporte/bacula

# INSTALANDO EDITOR VIM E APLICATIVO WGET

apt-get install vim -y
apt-get install wget -y

# BAIXANDO O BACULA NA PASTA CRIADA ANTERIORMENTE

wget 'https://sourceforge.net/projects/bacula/files/bacula/9.6.5/bacula-9.6.5.tar.gz' -O /home/suporte/bacula/bacula-9.6.5.tar.gz

# DESCOMPACTANDO O BACULA BAIXADO NA PASTA /USR/SRC/

tar -xvzf /home/suporte/bacula/bacula-9.6.5.tar.gz -C /usr/src/

# INSTALANDO ALGUMAS DEPENDENCIAS

apt-get install -y build-essential zlib1g-dev liblzo2-dev libacl1-dev libssl-dev

# E VAMOS PARA A PRIMEIRA COMPILAÇÃO

cd /usr/src/bacula-9.6.5/ && ./configure --enable-client-only --enable-build-dird=no --enable-build-stored=no --bindir=/usr/bin --sbindir=/usr/sbin --with-scriptdir=/etc/bacula/scripts --with-working-dir=/var/lib/bacula --with-logdir=/var/log --enable-smartalloc

# E VAMOS PARA A SEGUNDA COMPILAÇÃO

cd /usr/src/bacula-9.6.5/ && make -j8 && make install && make install-autostart-fd

# INICIANDO OS SISTEMAS E RESTARTANDO ELES

service bacula-fd start

service bacula-fd restart

# UM BACKUP NÃO FAZ MAL A NINGUEM

cp /etc/bacula/bacula-fd.conf /etc/bacula/bacula-fd.conf-bkp-default

# EDITANDO O CONF PARA ALTERAÇÃO DE NOME, PORTA E SENHA DO DIRECTOR

vim /etc/bacula/bacula-fd.conf
