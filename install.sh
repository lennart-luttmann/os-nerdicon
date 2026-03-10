#!/bin/sh

# Ensure user is root.
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run as root."
    exit 1
fi

# Ensure build directory exists.
if [ ! -d "build" ]; then
    if [ -d ".git" ]; then
        echo "Error: Could not find \"build\" directory. Run \"make all\" first"
    else
        echo "Error: Could not find \"build\" directory."
    fi
    exit 1
fi

# Ensure include directory exists.
if [ ! -d "include" ]; then
    echo "Error: Could not find \"include\" directory."
    exit 1
fi

# Install files.
cp build/osnerdicon /usr/bin/osnerdicon
cp build/libosnerdicon.so /usr/lib/libosnerdicon.so
cp include/osnerdicon.h /usr/include/osnerdicon.h

# Install uninstaller.
mkdir -p /usr/share/osnerdicon
cp uninstall.sh /usr/share/osnerdicon/uninstall.sh
chmod +x /usr/share/osnerdicon/uninstall.sh
cp manifest.txt /usr/share/osnerdicon/manifest.txt

echo "OS-Nerdicon has successfully been installed."
echo "Call \"/usr/share/osnerdicon/uninstall.sh\" to uninstall."
