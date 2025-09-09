#!/bin/bash
# controller-setup.sh
dialog --title "Controller Setup" --msgbox "Make sure your controller is in pairing mode!" 7 40

bluetoothctl --timeout 20 scan on > /tmp/bt_scan.txt &

sleep 5
devices=$(grep "Device" /tmp/bt_scan.txt | awk '{print $2, $3, $4, $5, $6}' | uniq)

choice=$(dialog --title "Choose Controller" --menu "Select device:" 15 60 4 $devices 2>&1 >/dev/tty)

if [ -n "$choice" ]; then
    bluetoothctl <<EOF
    pair $choice
    trust $choice
    connect $choice
EOF
    dialog --title "Success" --msgbox "Controller $choice paired and connected!" 7 40
fi
