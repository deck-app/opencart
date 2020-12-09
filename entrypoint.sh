#!/bin/sh

mkdir -p /opt/opencart
cd /opt/opencart
curl -sSL https://github.com/opencart/opencart/releases/download/3.0.3.6/opencart-3.0.3.6.zip -o opencart.zip
echo "41c7e7ec49d389fc4c2204efb40289e6  opencart.zip" | md5sum -c
unzip opencart.zip 'upload/*' -d /opt/opencart
mv /opt/opencart/upload/* /var/www/html/
mv /var/www/html/config-dist.php /var/www/html/config.php
mv /var/www/html/admin/config-dist.php /var/www/html/admin/config.php
rm -rf opencart.zip
sed -i 's/MYSQL40//g' install/model/install/install.php
chown -R www-data:www-data /var/www
