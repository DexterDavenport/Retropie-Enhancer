#!/bin/bash
# install.sh - RetroPie Enhancer Installer
# Run this script to install controller, wifi, and netplay helpers.

set -e

echo "🚀 Installing RetroPie Enhancer..."

# --- Step 1: Install dependencies ---
echo "📦 Installing required packages..."
sudo apt-get update
sudo apt-get install -y dialog bluetooth bluez network-manager

# --- Step 2: Create scripts directory ---
SCRIPTS_DIR="$HOME/RetroPie/scripts"
MENU_DIR="$HOME/RetroPie/retropiemenu"

mkdir -p "$SCRIPTS_DIR"
mkdir -p "$MENU_DIR"

# --- Step 3: Write helper scripts ---

# Controller setup script
cat > "$SCRIPTS_DIR/controller-setup.sh" <<'EOF'
#!/bin/bash
dialog --title "Controller Setup" --msgbox "Put your controller in pairing mode!" 7 40

bluetoothctl --timeout 20 scan on > /tmp/bt_scan.txt &

sleep 5
devices=$(grep "Device" /tmp/bt_scan.txt | awk '{print $2, $3, $4, $5, $6}' | uniq)

choice=$(dialog --title "Choose Controller" --menu "Select device:" 15 60 4 $devices 2>&1 >/dev/tty)

if [ -n "$choice" ]; then
    bluetoothctl <<EOC
    pair $choice
    trust $choice
    connect $choice
EOC
    dialog --title "Success" --msgbox "Controller $choice paired and connected!" 7 40
fi
EOF
chmod +x "$SCRIPTS_DIR/controller-setup.sh"

# WiFi setup script
cat > "$SCRIPTS_DIR/wifi-setup.sh" <<'EOF'
#!/bin/bash
networks=$(nmcli -t -f SSID dev wifi | sort -u)
choice=$(dialog --title "WiFi Networks" --menu "Select WiFi:" 20 60 10 $networks 2>&1 >/dev/tty)

if [ -n "$choice" ]; then
    password=$(dialog --title "WiFi Password" --passwordbox "Enter password for $choice" 8 40 2>&1 >/dev/tty)
    nmcli dev wifi connect "$choice" password "$password"
    if [ $? -eq 0 ]; then
        dialog --title "Success" --msgbox "Connected to $choice!" 7 40
    else
        dialog --title "Error" --msgbox "Failed to connect to $choice" 7 40
    fi
fi
EOF
chmod +x "$SCRIPTS_DIR/wifi-setup.sh"

# Netplay launcher script
cat > "$SCRIPTS_DIR/netplay.sh" <<'EOF'
#!/bin/bash
choice=$(dialog --title "Multiplayer" --menu "Choose option:" 10 50 2 \
    1 "Host Game" \
    2 "Join Game" 2>&1 >/dev/tty)

if [ "$choice" == "1" ]; then
    retroarch --host
elif [ "$choice" == "2" ]; then
    ip=$(dialog --title "Join Game" --inputbox "Enter host IP address:" 8 40 2>&1 >/dev/tty)
    if [ -n "$ip" ]; then
        retroarch --connect "$ip"
    fi
fi
EOF
chmod +x "$SCRIPTS_DIR/netplay.sh"

# --- Step 4: Add menu shortcuts ---
echo "📝 Adding RetroPie menu entries..."
echo "$SCRIPTS_DIR/controller-setup.sh" > "$MENU_DIR/Controller Setup.sh"
echo "$SCRIPTS_DIR/wifi-setup.sh" > "$MENU_DIR/WiFi Setup.sh"
echo "$SCRIPTS_DIR/netplay.sh" > "$MENU_DIR/Netplay.sh"

chmod +x "$MENU_DIR/"*.sh

# --- Done ---
echo "✅ Installation complete!"
echo "➡ Restart EmulationStation to see new menu entries under RetroPie."
