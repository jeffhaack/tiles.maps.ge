# tiles.maps.ge

## Summary
This repo contains styles for maps.ge, along with server setup scripts.

## Setup Mapnik & Mod_tile
Clone the repo and run provision-server.sh

1. set up an ubuntu EC2 instance
2. login

	ssh -i kartulia.pem ubuntu@[SERVER ADDRESS]

2a. (optional) Make sure history is working so can record commands. Add this to ~/.bashrc

	unset HISTFILESIZE
	HISTSIZE=3000
	PROMPT_COMMAND="history -a"
	export HISTSIZE PROMPT_COMMAND
	shopt -s histappend

and run
	source ~/.bashrc

3. Install git

	sudo apt-get install git -y
	
4. Clone repo

	git clone https://github.com/jeffhaack/tiles.maps.ge.git

5. Run provision-server.sh

	cd tiles.maps.ge
	./provision-server.sh

6. On a weak server you'll need to remove some of the tilesets, as this creates 4 by default. Edit /etc/renderd.conf and reduce it to one, remembering to restart apache and renderd afterwords.

## Setup Tilestache Vector Tiles

1. Run provision-tilestache.sh

2. Run the tilestache server

	tilestache-server.py --ip=YOURIP

3. Open browser and you'll get something at YOURIP:8080/osmtest/17/81842/48799.json



## Notes
- SHOULD START USING http://openstreetmapdata.com/ instead of processed_p shapefiles
- Zoom levels above 18 don't work; don't understand why

sudo apt-get install python-pip -y
sudo pip install -U PIL modestmaps simplejson werkzeug

 

## More vector tile stuff
* Tilestache API - http://tilestache.org/doc/#configuring-tilestache
* Tutorial on setting up vector tiles with tilestache - http://mattmakesmaps.com/blog/2013/10/09/tilestache-rendering-topojson/
* Leaflet "plugin" for implementing vector geojson tiles - https://github.com/glenrobertson/leaflet-tilelayer-geojson
* Tilestache spec for vector tiles - http://tilestache.org/doc/TileStache.Vector.html
* A helpful tutorial on Tilestache - http://www.axismaps.com/blog/2012/01/dont-panic-an-absolute-beginners-guide-to-building-a-map-server/
* A nice read - http://www.mkgeomatics.com/wordpress/?p=389


* Try D3 to render client-side: http://bl.ocks.org/wboykinm/7393674
* Try polymaps to render client-side: http://polymaps.org/ex/population.html

## Todo
1. Set up server script for installing Tilecache (Done
2. Set up config for POIs in vector, and maybe one for roads

3. Try Polymaps rendering
4. Try D3 rendering
5. Try caching vector tiles on S3
6. Experiment with switching to a node run server rather than apache/python/mod_tile (https://github.com/mapnik/node-mapnik)


It's a bit annoying for vectors to be re-rendered the way they are with Leaflet.  Basically when you change zoom levels the tile layer is cleared, and new tiles are then loaded, which causes sort of a flickering effect.  Better to remove a tile from a different zoome level only when the replacement tiles have loaded, so as to prevent this. OR, thinking outside the box, don't load the base tile until vectors on top are loaded too, then display them at the same time.


