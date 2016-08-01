#/bin/bash

#example
#bash gettiles.sh 7 11 41 -117 47 -102  http://services.arcgisonline.com/ArcGIS/rest/services/Reference/World_Reference_Overlay/MapServer/tile/ yellowstone_base

#bash gettiles.sh 4 6 10 -170 70 -20  http://services.arcgisonline.com/arcgis/rest/services/World_Topo_Map/MapServer/tile/ world_topo_map_test

startzoom=$1
endzoom=$2
minlat=$3
minlon=$4
maxlat=$5
maxlon=$6
source_url=$7
destination_directory=$8

for zoom in $(seq $startzoom $endzoom)
do
mkdir -p $destination_directory/$zoom

tiles=$(python globalmaptiles.py $zoom $minlat $minlon $maxlat $maxlon | grep 'Google:' | sed -e 's/Google://g' -e 's/ /*/g')
echo $tiles
for tile in $tiles
 do
    echo $tile
   x=$(echo $tile | cut -d* -f2)
    echo $x
   y=$(echo $tile | cut -d* -f3)
    echo $y
   mkdir -p $destination_directory/$zoom/$x
   wget $source_url$zoom/$y/$x -O ./$destination_directory/$zoom/$x/$y
 done
done
