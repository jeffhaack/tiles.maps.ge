# tiles.maps.ge

## Summary
This repo contains styles for maps.ge, along with server setup scripts.

## Setup
Clone the repo and run provision-server.sh

1. set up an ubuntu EC2 instance
2. login

	ssh -i kartulia.pem ubuntu@[SERVER ADDRESS]

3. Install git

	sudo apt-get install git -y
	
4. Clone repo

	git clone https://github.com/jeffhaack/tiles.maps.ge.git

5. Run provision-server.sh

	cd tiles.maps.ge
	./provision-server.sh

#after creating instance, login with:

ssh -i kartulia.pem ubuntu@[SERVER ADDRESS]


## Notes
- SHOULD START USING http://openstreetmapdata.com/ instead of processed_p shapefiles
- Zoom levels above 18 don't work; don't understand why