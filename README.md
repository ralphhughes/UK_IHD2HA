# UK_IHD2HA
Simple program to watch the IHD (In-Home Display) of a UK smart meter via a webcam and send the values to HA (Home Assistant)

## Requirements
Developed on Raspberry Pi 1 with 256MB of RAM running Raspbian 10, but should work on any Raspbian\Debian\Ubuntu based distro. You will need a webcam supported by linux.

## Installation instructions
```
$ git clone https://github.com/ralphhughes/UK_IHD2HA.git

$ cd UK_IHD2HA

$ ./install.sh

$ ./snapshot.sh
```
The `snapshot.sh` file takes a pic with the webcam and saves it to `current.jpg` in the current folder. Open this image in your favourite image editor and draw a bounding box round the power digits on the IHD. Make a note of the top left coordinate and width and height of this box in pixels. 

Next go to your home assistant instance, click your username bottom left, then scroll down to the bottom of your profile page. Clcik "Create Token" in the "long-lived access tokens" section. Make a note of it. 

Next edit the config file and save the info you gathered in the last 2 steps into the config file
```
$ nano UK_IHD2HA.config

$ ./start.sh

$ tail -f fswebcam.log
```


## Design decisions
- easyOCR & pyTorch was way overkill and couldn't get it to compile on my Pi 1 architecture. Abandoned this approach.
- tesseract installed OK but couldn't get it to recognise the font from the IHD even with "ssd.traineddata". Abandoned this approach.
- fswebcam has a `--loop n` parameter which keeps the process running and takes a photo every n seconds. Also a "--exec" parameter which pretty much cemented my decision to do this as a shell script.
- ssocr is fast enough it can be spawned as soon as a new image is available
- Found an already existing seven segments ocr integration? Can't see anything about update rate or how it watches for a new image in the docs? Also I have no cameras set up in HA...
- getting data into HA via cmd line sensor via SSH requires setting up SSH keys, also this would be a local poll. Abandoned this approach
- restful sensor reading a python flask wrapper around ssocr. Showed promise, ultimately abandoned.
- mqtt broker. Apparently there's one built into HA, but as I've never used MQTT the learning curve was steep. Abandoned for now.

