# Major Incidents data

_Part of a collection of tools used to provide an API to NSW bushfire data_: [Data collector (this repo)](https://github.com/dylanfm/major-incidents-data), [Importer](https://github.com/DylanFM/incident-worker) and [GeoJSON API](https://github.com/DylanFM/bushfires)

Collects hourly snapshots of NSW RFS [major incidents data](http://www.rfs.nsw.gov.au/feeds/majorIncidents.xml). This data is delivered in a GeoRSS file. I'm collecting hourly snapshots so for the sake of importing past data. When the API is launched, I'll import the data I've collected and transition to regularly importing data using the [importer](https://github.com/DylanFM/incident-worker) itself.

## What's going on here

1. Download the GeoRSS feed from the RFS and store the response headers.
2. Convert the GeoRSS to GeoJSON using [Ogre's API](http://ogre.adc4gis.com/) and store it.
3. Commit these files to the git repo and push up to Github.

I have this running hourly at the moment. It began collecting snapshots on 30 October 2013.

## A note about the GeoRSS

The GeoRSS feed that is published is invalid. GeoRSS feeds are only allowed 1 geometry per-item. However, the RFS sometimes include multiple geometries (e.g. Point + Polygon(s)).

Ogre's converter, which has been used to convert the GeoRSS to the GeoJSON files included in this repo, ignores all but the 1st geometry. This means that the GeoJSON files here do not include any additional geometries.

I don't want to lose data like this, so [my importer](https://github.com/DylanFM/incident-worker) parses the XML manually and will store the entire geometries in the database. GeoJSON's spec allows for multiple geometries per-item, so the data provided by [the API](https://github.com/DylanFM/bushfires) is valid.