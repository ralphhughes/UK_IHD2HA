#!/bin/bash

# Import config
source UK_IHD2HA.config

# Set image to read from first argument on cmd line
IMAGE=$1

# Move previous current reading into lastread.txt
mv currentread.txt lastread.txt

# OCR the latest jpg to get the current reading
ssocr -d -1 -b black crop $AREA_X $AREA_Y $AREA_WIDTH $AREA_HEIGHT closing $IMAGE > currentread.txt

# Get the OCR results into variables
CURRENT_READING=`cat currentread.txt`
LAST_READING=`cat lastread.txt`

# Debug
echo "Last Reading: $LAST_READING"
echo "Current Reading: $CURRENT_READING"

# Check if the new reading has changed by checking OCR
if cmp -s lastread.txt currentread.txt; then
  echo "No change"
else
  echo "New reading"

  # Post process the result to convert kw to watts if needed
  if [[ $CURRENT_READING == *"."* ]]; then
    # We need bc to do floating point multiply as shell scripts only support integers
    CURRENT_READING=$(echo "scale=2; $CURRENT_READING * 1000" | bc)
  fi

  if (( $(echo "$CURRENT_READING <= $MIN_EXPECTED_READ" | bc -l) )) || (( $(echo "$CURRENT_READING >= $MAX_EXPECTED_READ" | bc -l) )); then
    echo "Value $CURRENT_READING is outside the range of $MIN_EXPECTED_READ to $MAX_EXPECTED_READ"
  else
    echo "Value $CURRENT_READING is within the range of $MIN_EXPECTED_READ to $MAX_EXPECTED_READ"
    # Send it to home assistant
    curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer $HA_ACCESS_TOKEN" \
    -d "{\"state\": \"$CURRENT_READING\", \"attributes\": {\"unit_of_measurement\": \"W\"}}" \
    $HA_URL/api/states/$HA_ENTITY_ID

  fi

fi
