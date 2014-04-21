#!/bin/bash


# Edit shapefile locations
sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/MapsgeBasic\/layers\/land\/10m-land.shp"/"\/etc\/mapnik-osm-data\/maps-ge-styles\/shp\/10m-land.shp"/ <$1 >output1.xml
sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/MapsgeBasic\/layers\/processed_p\/coastline-good.shp"/"\/etc\/mapnik-osm-data\/maps-ge-styles\/shp\/coastline-good.shp"/ <output1.xml >output2.xml
sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/MapsgeBasic\/layers\/shoreline_300\/shoreline_300.shp"/"\/etc\/mapnik-osm-data\/maps-ge-styles\/shp\/shoreline_300.shp"/ <output2.xml >output3.xml

# Edit database settings
sed s/"<Parameter name=\"user\"><!\[CDATA\[postgres\]\]><\/Parameter>"/"<Parameter name=\"user\"><!\[CDATA\[osm\]\]><\/Parameter><Parameter name=\"password\"><!\[CDATA\[ruka!053\]\]><\/Parameter>"/ <output3.xml >output4.xml

# Edit icon and font locations
sed s/"img\/icon\/"/"\/etc\/mapnik-osm-data\/maps-ge-styles\/icon\/"/ <output4.xml >output5.xml
sed s/"font-directory=\".\/fonts\""/"font-directory=\"\/etc\/mapnik-osm-data\/maps-ge-styles\/fonts\/\""/ <output5.xml >output6.xml

# Delete parameter lines at beginning of file
sed -i.bak -e '5,15d' output6.xml

# Change file names of all the silly stuff I've made because I don't know how to use sed
mv output6.xml style.xml
rm output*



# Test
#sed s/"<Parameter name=\"attribution\"><!\[CDATA"/"|Perimeterjeff!!!!"/ <output4.xml >output5.xml
