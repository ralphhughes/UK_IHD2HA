# UK_IHD2HA
Simple program to watch the IHD (In-Home Display) of a UK smart meter via a webcam and send the values to HA (Home Assistant)

## Requirements
Developed on Raspberry Pi 1 with 256MB of RAM running Raspbian 10, but should work on any Raspbian\Debian\Ubuntu based distro. You will need a webcam supported by linux.

## Installation instructions
```
$ git clone https://github.com/ralphhughes/UK_IHD2HA.git

$ cd UK_IHD2HA

$ ./install.sh
```
Then in home assistant, add this to your configuration.yaml:
```
# Example configuration.yaml entry
sensor:
  - platform: rest
    name: IHD Power
    resource: http://192.168.1.1:5000/sensor
    method: GET
    value_template: '{{ value_json.sensor_value }}'
    unit_of_measurement: 'W'
    device_class: power
    scan_interval: 10
```

## Usage
How to start\stop server and check status once I get that bit coded...

## Todo

fswebcam has a `--loop n` parameter which keeps the process running and takes a photo every n seconds
motion can continuosly watch a webcam feed and fire a process and save a snapshot when the image changes. This seems the most promising.

ssocr is fast enough it can be spawned as soon as a new image is available

Methods of getting values into HA:
- cmd line sensor via SSH requires setting up SSH keys, also this would be a local poll
- restful sensor reading the python flask wrapper
- seven segments ocr integration? Can't see anything about update rate or how it watches for a new image in the docs?
- mqtt broker?
