#!/bin/sh

# Ensure user is root.
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run as root."
    exit 1
fi

# Assert manifest.
SCRIPT_DIR="$(dirname "$0")"
MANIFEST="$SCRIPT_DIR/manifest.txt"
if [ ! -f "$MANIFEST" ]; then
    echo "Error: Manifest file not found at $MANIFEST"
    exit 1
fi

# Remove manifest files
while IFS= read -r entry || [ -n "$entry" ]; do
    [ -z "$entry" ] && continue
    rm -rf -- "$entry"
done < "$MANIFEST"

echo "OS-Nerdicon has successfully been uninstalled."

# Remove the manifest and uninstaller.
rm -f -- "$MANIFEST"
rm -f -- "$0"
