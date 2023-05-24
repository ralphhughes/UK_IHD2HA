fswebcam --background --pid fswebcam.pid --log fswebcam.log --loop 10 \
-d v4l2:/dev/video0 -r 1280x720 -S 7 --no-banner \
current.jpg

# --exec './readIHD.sh' \
#current.jpg
