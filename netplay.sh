#!/bin/bash
# netplay.sh
choice=$(dialog --title "Multiplayer" --menu "Choose option:" 10 50 2 \
    1 "Host Game" \
    2 "Join Game" 2>&1 >/dev/tty)

if [ "$choice" == "1" ]; then
    retroarch --host
elif [ "$choice" == "2" ]; then
    ip=$(dialog --title "Join Game" --inputbox "Enter host IP address:" 8 40 2>&1 >/dev/tty)
    retroarch --connect "$ip"
fi
