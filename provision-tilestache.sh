#!/bin/bash
# provision-server.sh
#
# This script sets up the server to serve vector tiles using Tilecache.
# Tested to run after running provision-server.sh
# 

# DB_NAME should be the same as in provision_server.sh
DB_NAME=georgia
PG_HBA=/etc/postgresql/9.3/main/pg_hba.conf

# Install pip
curl -O -L https://raw.github.com/pypa/pip/master/contrib/get-pip.py
sudo python get-pip.py

# Install some stuff
sudo aptitude install python-dev python-pip python-mapnik libpq-dev -y
#sudo aptitude install libjpeg-dev zlib1g-dev -y not sure i need this

# Install python modules
sudo pip install modestmaps simplejson werkzeug image shapely psycopg2
easy_install pil

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
rm tilecache.cfg
cp ~/tiles.maps.ge/tilecache.cfg ./

# Now run:
# tilestache-server.py --ip=YOURIP
# And you'll get something at YOURIP:8080/osmtest/17/81842/48799.json



