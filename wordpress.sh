#!/bin/bash
apt-get update -y
apt-get install -y apache2 mysql-client php libapache2-mod-php php-mysql
# MySQL root password
MYSQL_ROOT_PASSWORD="kaizen123"
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
apt-get install -y mysql-server
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE wordpress;"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER 'wordpress'@'%' IDENTIFIED BY 'kaizen123';"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%';"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
# WordPress installation
wget https://wordpress.org/latest.tar.gz -P /tmp
tar -zxvf /tmp/latest.tar.gz -C /var/www/html
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sed -i 's/database_name_here/wordpress/g' /var/www/html/wordpress/wp-config.php
sed -i 's/username_here/wordpress/g' /var/www/html/wordpress/wp-config.php
sed -i 's/password_here/kaizen123/g' /var/www/html/wordpress/wp-config.php
chown -R www-data:www-data /var/www/html/wordpress
sudo rm -rf /var/www/html/index.html
sudo mv /var/www/html/wordpress/* /var/www/html
service apache2 restart


 