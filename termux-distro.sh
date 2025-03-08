#!/bin/bash
# GitHub: https://github.com/xconexionx
# This is free software

clear
echo "Please select the distro you want to install:"
echo "1) Alpine Linux"
echo "2) Arch Linux"
echo "3) Void Linux"
read -p "Which Distro to install: " choice

if [ $choice -eq 2 ]; then
  ARCH_DIR="arch1"
  ARCH_URL="http://os.archlinuxarm.org/os/ArchLinuxARM-am33x-latest.tar.gz"
  COMMAND_FILE="$PREFIX/bin/start-arch"
  DN="Arch Linux"
  DIS="start-arch"
elif [ $choice -eq 1 ]; then
  ARCH_DIR="alpine2"
  ARCH_URL="https://dl-cdn.alpinelinux.org/alpine/v3.21/releases/armv7/alpine-minirootfs-3.21.3-armv7.tar.gz"
  COMMAND_FILE="$PREFIX/bin/start-alpine"
  DN="Alpine Linux"
  DIS="start-alpine"
elif [ $choice -eq 3 ]; then
  ARCH_DIR="void"
  ARCH_URL="https://repo-default.voidlinux.org/live/current/void-armv7l-ROOTFS-20250202.tar.xz"
  COMMAND_FILE="$PREFIX/bin/start-void"
  DN="Void Linux"
  DIS="start-void"
else
  echo "Invalid Option: Exiting script"
  exit 1
fi

pkg install libarchive -y
pkg install wget -y
pkg install proot -y

cd
mkdir -p ~/$ARCH_DIR
cd ~/$ARCH_DIR

wget $ARCH_URL
FILENAME=$(basename $ARCH_URL)

if [[ $FILENAME == *.tar.gz ]]; then
  tar -xzf $FILENAME
elif [[ $FILENAME == *.tar.xz ]]; then
  tar -xJf $FILENAME
else
  echo "Unsupported file format: $FILENAME"
  exit 1
fi

rm $FILENAME

echo -e "unset LD_PRELOAD\nproot -r ~/$ARCH_DIR -0 -b /proc:/proc -b /sys:/sys" > $COMMAND_FILE
chmod +x $COMMAND_FILE

clear
echo "Install Complete! Run the command $DIS to launch $DN"
