#!/bin/bash

# Import config
source UK_IHD2HA.config

# Move previous current reading into lastread.txt
mv currentread.txt lastread.txt

# OCR the latest jpg to get the current reading
ssocr -d -1 -b black crop $AREA_X $AREA_Y $AREA_WIDTH $AREA_HEIGHT closing current.jpg > currentread.txt

echo "Last Reading: `cat lastread.txt`"
echo "Current Reading: `cat currentread.txt`"

# Check if the new reading has changed
if cmp -s lastread.txt currentread.txt; then
  echo "No change"
else
  echo "New reading"
  # curl
fi
