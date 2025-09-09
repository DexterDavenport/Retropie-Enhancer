# RetroPie Enhancer

RetroPie Enhancer is a set of lightweight scripts that make RetroPie easier to use.  
It improves common pain points such as:

- **Controller setup** → Simple menu to pair and connect Bluetooth controllers.  
- **WiFi setup** → Easy way to connect to WiFi networks without digging through menus.  
- **Multiplayer setup** → Quick launcher for RetroArch netplay (host or join games).  

The goal is to make RetroPie more console-like and beginner-friendly, while still being lightweight and portable.  
You can run this on **any Raspberry Pi that supports RetroPie** (Pi Zero 2 W, Pi 3, Pi 4, etc.).

---

## ✨ Features

- Plug-and-play installer (just run one command).  
- Adds scripts directly into the **RetroPie menu** inside EmulationStation.  
- Uses simple text-based menus (`dialog`) so it works with just a controller or keyboard.  
- Easy to upgrade: re-run the installer anytime on a new system.  

---

## 🚀 Installation

SSH into your Raspberry Pi (or open a terminal) and run:

```bash
curl -sSL https://raw.githubusercontent.com/YOURNAME/retropie-enhancer/main/install.sh | bash
```

This will:

1. Install required dependencies.

2. Copy helper scripts into ~/RetroPie/scripts/.

3. Add shortcuts in the RetroPie menu for Controller Setup, WiFi Setup, and Netplay.

---

## 📖 Usage

After installation, open the RetroPie menu inside EmulationStation.
You’ll see three new options:

1. Controller Setup
  - Scan for Bluetooth controllers.
  - Pair, trust, and connect in one step.

2. WiFi Setup
  - Scan for available networks.
  - Enter password to connect.

3. Multiplayer (Netplay)
  - Choose to Host Game or Join Game.
  - Enter an IP if joining another Pi.

---

## 🛠 Requirements

- Raspberry Pi running RetroPie (any supported model).
- Basic network access (Ethernet or WiFi dongle on older models).
- At least one Bluetooth or USB controller.

---

## 🔧 Customization

All helper scripts are stored in:

```bash
~/RetroPie/scripts/
```

Feel free to edit them to add new features, change defaults, or customize dialog boxes.

---

## 📦 Project Structure

```bash
retropie-enhancer/
│
├── install.sh              # Main installer script
├── scripts/
│   ├── controller-setup.sh # Easy controller pairing
│   ├── wifi-setup.sh       # WiFi manager
│   └── netplay.sh          # Netplay launcher
└── README.md
```

---

## 🤝 Contributing

PRs and suggestions are welcome! If you have ideas for new helper scripts (like save-state sync, backup tools, or theme installers), feel free to add them.

---

# 📜 License

MIT License. Do whatever you like, just don’t hold me liable if you break your Pi 🙂
