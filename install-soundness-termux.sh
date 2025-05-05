#!/bin/bash
#========================================#
#     SAINT KHEN OFFICIAL SETUP SCRIPT   #
#     CREATED BY: @ADMIRKHEN (TWITTER)   #
#     github.com/emmogrin                #
#========================================#

echo "=========================================="
echo "       SAINT KHEN PRESENTS                "
echo "     SOUNDNESS LAYER INSTALLER            "
echo "      FOLLOW ME ON TWITTER: @ADMIRKHEN    "
echo "=========================================="

# Step 1: Termux Update & Base Packages
pkg update -y && pkg upgrade -y
pkg install -y proot-distro curl wget

# Step 2: Install Ubuntu via proot-distro
proot-distro install ubuntu

# Step 3: Create Auto-Setup Script Inside Ubuntu
cat << 'EOF' > ~/.soundness-setup.sh
#!/bin/bash
echo "=========================================="
echo "  NOW ENTERING UBUNTU ENVIRONMENT         "
echo "       SAINT KHEN — @ADMIRKHEN            "
echo "=========================================="

apt update && apt upgrade -y

# Install dependencies
apt install -y build-essential protobuf-compiler curl wget pkg-config \
libcrypto++-dev libc6-dev openssl libssl-dev

# Install Soundness CLI
curl -sSL raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Finalize installation
soundnessup install
soundnessup update

# Generate Soundness Key
soundness-cli generate-key --name my-key
soundness-cli export-key --name my-key

echo ""
echo "=========================================="
echo "   SETUP COMPLETE BY SAINT KHEN           "
echo "  PUBLIC KEY + SEED ABOVE — SAVE IT NOW!  "
echo "    TWITTER: https://x.com/ADMIRKHEN      "
echo "=========================================="
EOF

chmod +x ~/.soundness-setup.sh

# Step 4: Login and Execute Script in Ubuntu
proot-distro login ubuntu -- bash ~/../usr/home/.soundness-setup.sh
