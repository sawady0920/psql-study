docker pull postgres:11.12


## コンテナ内
apt update; apt -y upgrade


## pg_ctlコマンド

su postgres
/usr/lib/postgresql/11/bin/pg_ctl status