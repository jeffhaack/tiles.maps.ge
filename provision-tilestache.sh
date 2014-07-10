#!/bin/bash
# provision-server.sh
#
# This script sets up the server to serve vector tiles using Tilecache.
# Tested to run after running provision-server.sh
# 

# DB_NAME should be the same as in provision_server.sh
DB_NAME=georgia
PG_HBA=/etc/postgresql/9.3/main/pg_hba.conf
APACHE_CFG=/etc/apache2/apache2.conf

# Install some stuff
sudo aptitude install python-dev python-pip python-mapnik libpq-dev -y
#sudo aptitude install libjpeg-dev zlib1g-dev -y not sure i need this

# Install pip
curl -O -L https://raw.github.com/pypa/pip/master/contrib/get-pip.py
sudo python get-pip.py

# Install python modules
sudo pip install modestmaps simplejson werkzeug image shapely psycopg2
sudo easy_install pil

# Make postgres trusting
sudo sed -i s/"md5"/"trust"/ $PG_HBA
sudo service postgresql restart

# Install Tilestache
cd ~
git clone https://github.com/TileStache/TileStache.git
cd TileStache
sudo python setup.py install

# Now run:
# tilestache-server.py --ip=YOURIP
# And you'll get something at YOURIP:8080/osm/preview.html

# Setup my own
rm tilestache.cfg
cp ~/tiles.maps.ge/tilestache.cfg ./

echo "Now run:"
echo "tilestache-server.py --ip=YOURIP"
echo "And you'll get something at YOURIP:8080/osmtest/17/81842/48799.json"




# So the above all works...next...try...

# Setup to run through Apache
# Install mod_python (wow, it's nice and easy)
sudo aptitude install libapache2-mod-python

# Add handler to apache config
<Directory /var/www/tiles>
  AddHandler mod_python .py
  PythonHandler TileStache::modpythonHandler
  PythonOption config /home/ubuntu/TileStache/tilestache.cfg
</Directory>

add this to $APACHE_CFG

# Setup caching in /tmp/stache
sudo mkdir /tmp/stache
sudo chown www-data:www-data /tmp/stache

# Restart Apache
sudo service apache2 restart











