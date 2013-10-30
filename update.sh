#!/bin/bash

TIMESTAMP=`date +%Y%m%d%H%M%S`

# Pull down the GeoRSS feed, storing the XML and the headers in 2 files
curl -o $TIMESTAMP.xml -D $TIMESTAMP.txt http://www.rfs.nsw.gov.au/feeds/majorIncidents.xml

echo "Headers stored in $TIMESTAMP.txt"
echo "GeoRSS stored in $TIMESTAMP.xml"

# Convert the GeoRSS to GeoJSON
curl -F upload=@$TIMESTAMP.xml -o $TIMESTAMP.json http://ogre.adc4gis.com/convert

echo "GeoRSS converted to GeoJSON and stored in $TIMESTAMP.json"

# Add the files to git and send on up
git add $TIMESTAMP*
git commit -m "$TIMESTAMP - Updated GeoRSS, headers and GeoJSON"
git push origin master
