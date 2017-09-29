#!/bin/sh

/usr/sbin/rfkill unblock 0

/usr/bin/pactl load-module module-bluetooth-discover
/usr/bin/pactl load-module module-loopback

