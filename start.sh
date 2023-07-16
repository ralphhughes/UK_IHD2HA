#!/bin/bash

rm fswebcam.log

# Removed --log fswebcam.log
fswebcam --background --pid fswebcam.pid --loop 2 \
-d v4l2:/dev/video0 -r 1280x720 -S 7 --no-banner \
--exec './readIHD.sh current.jpg' \
current.jpg
