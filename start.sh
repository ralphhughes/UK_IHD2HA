#!/bin/bash

rm fswebcam.log

fswebcam --background --pid fswebcam.pid --log fswebcam.log --loop 2 \
-d v4l2:/dev/video0 -r 1280x720 -S 7 --no-banner \
--exec './readIHD.sh' \
current.jpg
