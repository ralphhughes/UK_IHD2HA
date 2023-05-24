#!/bin/bash

fswebcam -d v4l2:/dev/video0 -r 1280x720 -S 7 --no-banner current.jpg

