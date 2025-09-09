#!/bin/bash
# wifi-setup.sh
networks=$(nmcli -t -f SSID dev wifi | sort -u)
choice=$(dialog --title "WiFi Networks" --menu "Select WiFi:" 20 60 10 $networks 2>&1 >/dev/tty)

if [ -n "$choice" ]; then
    password=$(dialog --title "WiFi Password" --passwordbox "Enter password for $choice" 8 40 2>&1 >/dev/tty)
    nmcli dev wifi connect "$choice" password "$password"
    dialog --title "Success" --msgbox "Connected to $choice!" 7 40
fi
