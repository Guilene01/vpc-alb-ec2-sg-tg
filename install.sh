#!/bin/bash
sudo yum install wget httpd mysql php php-mysql -y
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz
sudo cp -r wordpress/* /var/www/html
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo cd /var/www/html
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo chown -R apache:apache /var/www/html
sudo systemctl start httpd 
sudo systemctl enable httpd