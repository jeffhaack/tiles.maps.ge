#!/bin/bash


# Edit shapefile locations
#sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/.*\/layers\/land\/10m-land.shp"/"\/etc\/mapnik-osm-data\/maps-ge-styles\/shp\/10m-land.shp"/ <$1 >output1.xml
#sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/.*\/layers\/processed_p\/coastline-good.shp"/"\/etc\/mapnik-osm-data\/maps-ge-styles\/shp\/coastline-good.shp"/ <output1.xml >output2.xml
#sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/.*\/layers\/shoreline_300\/shoreline_300.shp"/"\/etc\/mapnik-osm-data\/maps-ge-styles\/shp\/shoreline_300.shp"/ <output2.xml >output3.xml
#sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/.*\/layers\/regions\/region.shp"/"\/etc\/mapnik-osm-data\/maps-ge-styles\/shp\/region.shp"/ <output3.xml >output4.xml
#sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/.*\/layers\/regions\/georgia.shp"/"\/etc\/mapnik-osm-data\/maps-ge-styles\/shp\/georgia.shp"/ <output4.xml >output5.xml
sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/.*\/layers\/land\/10m-land.shp"/"shp\/10m-land.shp"/ <$1 >output1.xml
sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/.*\/layers\/processed_p\/coastline-good.shp"/"shp\/coastline-good.shp"/ <output1.xml >output2.xml
sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/.*\/layers\/shoreline_300\/shoreline_300.shp"/"shp\/shoreline_300.shp"/ <output2.xml >output3.xml
sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/.*\/layers\/regions\/region.shp"/"shp\/region.shp"/ <output3.xml >output4.xml
sed s/"\/Users\/jeff\/Documents\/MapBox\/project\/.*\/layers\/regions\/georgia.shp"/"shp\/georgia.shp"/ <output4.xml >output5.xml


# Edit database settings
sed s/"<Parameter name=\"user\"><!\[CDATA\[postgres\]\]><\/Parameter>"/"<Parameter name=\"user\"><!\[CDATA\[osm\]\]><\/Parameter><Parameter name=\"password\"><!\[CDATA\[ruka!053\]\]><\/Parameter>"/ <output5.xml >output6.xml

# Edit icon and font locations
#sed s/"img\/icon\/"/"\/etc\/mapnik-osm-data\/maps-ge-styles\/icon\/"/ <output6.xml >output7.xml
#sed s/"font-directory=\".\/fonts\""/"font-directory=\"\/etc\/mapnik-osm-data\/maps-ge-styles\/fonts\/\""/ <output7.xml >output8.xml
sed s/"img\/icon\/"/"icon\/"/ <output6.xml >output7.xml
sed s/"font-directory=\".\/fonts\""/"font-directory=\"fonts\/\""/ <output7.xml >output8.xml

# Delete parameter lines at beginning of file
sed -i.bak -e '5,15d' output8.xml

# Change file names of all the silly stuff I've made because I don't know how to use sed
mv output8.xml style.xml
rm output*



# Test
#sed s/"<Parameter name=\"attribution\"><!\[CDATA"/"|Perimeterjeff!!!!"/ <output4.xml >output5.xml
