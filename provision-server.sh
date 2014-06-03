# provision-server.sh
#
# This script sets up an Ubuntu (tested with 14.04) server
# to serve png tiles designed for maps.ge. This includes
# the open-en, open-ka, transparent-en, and transparent-ka
# tilesets. The variables at
# the top of this need to be set.  Also I don't know of a way
# to escape a few prompts that occur during installation. However,
# the defaults should be fine to accept.

# Make sure these variables work
DB_NAME=georgia
OSM_FILE=http://export.hotosm.org/download/020326/rawdata.osm.pbf
PG_HBA=/etc/postgresql/9.3/main/pg_hba.conf

# Install a few things
sudo apt-get install software-properties-common -y
sudo apt-get install git -y # should be installed already if you've cloned this repo
sudo add-apt-repository ppa:kakrueger/openstreetmap -y
sudo apt-get update

# Answer yes, no, no
sudo apt-get install libapache2-mod-tile -y

# Get OSM Data
wget $OSM_FILE

# Get additional shapefiles
cd shp
wget http://mapbox-geodata.s3.amazonaws.com/natural-earth-1.3.0/physical/10m-land.zip
wget http://tilemill-data.s3.amazonaws.com/osm/coastline-good.zip
wget http://tilemill-data.s3.amazonaws.com/osm/shoreline_300.zip
unzip 10m-land.zip
unzip coastline-good.zip 
unzip shoreline_300.zip 

# Make postgres work 
sudo sed -i s/"peer"/"trust"/ $PG_HBA
sudo service postgresql restart

# Let's create a new database
psql -U postgres -c "create database $DB_NAME;"
psql -U postgres -d $DB_NAME -c "CREATE EXTENSION postgis;"

# Load data into database (don't have a lot of memory on a micro instance)
cd ..
osm2pgsql -U postgres --slim -C 400 --cache-strategy sparse -d $DB_NAME -S georgia.style rawdata.osm.pbf

# NOT WORRYING ABOUT UPDATING DATABASE

# Copy a new renderd.conf file into /etc/renderd.conf
sudo rm /etc/renderd.conf
sudo cp renderd.conf /etc/renderd.conf


# Restart renderd
sudo touch /var/lib/mod_tile/planet-import-complete
sudo service renderd restart

# Now do updates to DB
sudo apt-get install osmosis
sudo /usr/bin/install-postgis-osm-user.sh $DB_NAME www-data
sudo mkdir /var/log/tiles
sudo chown www-data /var/log/tiles
sudo -u www-data /usr/bin/openstreetmap-tiles-update-expire 2012-04-21
### NEED to get the right state file in /var/lib/mod_tile/.osmosis/ - WOULD BE GOOD TO CREATE AN ALGO FOR THIS
sudo sed -i s/"http:\/\/planet.openstreetmap.org\/minute-replicate"/"http:\/\/planet.openstreetmap.org\/replication\/minute\/"/ /var/lib/mod_tile/.osmosis/configuration.txt

/var/lib/mod_tile/.osmosis/configuration.txt

