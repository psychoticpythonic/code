#!/bin/bash

killall -q polybar
polybar -cr /home/notroot/.config/polybar/bars/status.ini &
polybar -cr /home/notroot/.config/polybar/bars/groups.ini &
#polybar -cr /home/notroot/.config/polybar/bars/time.ini &
#polybar -cr /home/notroot/.config/polybar/bars/polypomo.ini &
#polybar -cr /home/notroot/.config/polybar/bars/net.ini &
