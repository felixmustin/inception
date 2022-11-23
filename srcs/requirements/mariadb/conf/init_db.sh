#!/bin/bash
service mysql start
if [ ! -d /var/lib/mysql/$DB_DATABASE ];
then
	echo "mariadb already configured"
else
#	mysql -e "CREATE DATABASE $DB_DATABASE;"
#	mysql -e "CREATE USER '${DB_USERNAME}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
#	mysql -e "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USERNAME}'@'%';"
	mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password;"
	mysql -u root -e "ALTER USER root@localhost IDENTIFIED BY '$DB_ROOT_PASSWORD';"
	mysql -u root -p${DB_ROOT_PASSWORD} -e "CREATE DATABASE $DB_DATABASE;"
	mysql -u root -p${DB_ROOT_PASSWORD} -e "CREATE USER '$DB_USERNAME' IDENTIFIED BY '$DB_PASSWORD';"
	mysql -u root -p${DB_ROOT_PASSWORD} -e "GRANT USAGE ON $DB_DATABASE.* TO '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;"
	mysql -u root -p${DB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;;"
	mysql -u root -p${DB_ROOT_PASSWORD} -e "CREATE USER 'evaluator' IDENTIFIED BY '$DB_PASSWORD';"
	mysql -u root -p${DB_ROOT_PASSWORD} -e "GRANT USAGE ON $DB_DATABASE.* TO 'evaluator'@'%' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;"
fi





#if [ ! -d /var/lib/mysql/${DB_DATABASE} ]; then
#    mysqld&
#    until mysqladmin ping; do
#        sleep 2
#    done
#    cd /root/
#    mysql -e "CREATE DATABASE ${DB_DATABASE};"
#    mysql -e "CREATE USER '${DB_ROOT_USERNAME}'@'%' IDENTIFIED BY '${DB_ROOT__PASSWORD}';"
#    mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_ROOT_USERNAME}'@'%';"
#    mysql -e "FLUSH PRIVILEGES;"
#    mysql -e "CREATE USER '${DB_USERNAME}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
#    mysql -e "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USERNAME}'@'%';"
#    mysql -e "FLUSH PRIVILEGES;"
#    mysql -e "DELETE FROM mysql.user WHERE user=''"
#    mysql -e "DELETE FROM mysql.user WHERE user='root'"
#    mysql -e "FLUSH PRIVILEGES;"
#    killall mysqld
#fi

#exec "$@"
