fswebcam -d v4l2:/dev/video0 -r 1280x720 -D 1 -S 10 -F 2 --no-banner current.jpg
ssocr -d -1 -b black crop 535 182 426 169 closing current.jpg > lastread.txt
