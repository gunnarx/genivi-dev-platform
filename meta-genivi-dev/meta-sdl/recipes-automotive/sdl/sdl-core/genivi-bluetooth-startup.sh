#!/bin/sh

bluetoothctl <<< "power on"

/usr/bin/pactl load-module module-bluetooth-discover
/usr/bin/pactl load-module module-loopback

