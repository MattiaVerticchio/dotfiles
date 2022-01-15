#!/usr/bin/env bash

DIR=$HOME/Brave
URL=$(curl -s "https://api.github.com/repos/brave/brave-browser/releases" \
| awk '/browser_download_url/ && /linux-amd64/ && ! /dev|nightly|beta/' \
| head -n 1 \
| cut -d : -f 2,3 \
| tr -d \")
curl -Lo brave.zip $URL
mkdir -p $DIR 
unzip brave.zip -d $DIR 
rm brave.zip
curl -LO https://raw.githubusercontent.com/MattiaVerticchio/dotfiles/main/brave-browser.desktop
mv brave-browser.desktop $HOME/.local/share/applications
sed -i "s\Exec=/usr/bin/brave-browser-stable\Exec=env FONTCONFIG_PATH=/usr/share/defaults/fonts $DIR/brave-browser\g" "$HOME/.local/share/applications/brave-browser.desktop"  
sed -i "s\Icon=brave-browser\Icon=$DIR/product_logo_256.png\g" "$HOME/.local/share/applications/brave-browser.desktop"
