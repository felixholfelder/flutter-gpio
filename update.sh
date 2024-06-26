#!/usr/bin/env bash

appName=flutter-gpio
target=linux-arm64

#Check if version parameter was passed
if [ -n "$1" ]; then
  newestRelease=$1
else
  newestRelease=$(curl https://api.github.com/repos/felixholfelder/$appName/releases/latest | grep tag_name | sed -E 's/.*"([^"]+)".*/\1/')
fi
echo "Neueste Version: $newestRelease"

#Get current version
currRelease=$(git rev-parse --abbrev-ref HEAD)
echo "Aktuelle Version: $currRelease"

#Check if version is current
if [ -"$newestRelease" != "$currRelease" ]; then
    rm -rf $appName
    git clone https://github.com/felixholfelder/$appName.git --branch "$newestRelease"

    flutter build linux --release --target-platform $target
fi

#Start app
./$appName/build/linux/$target/release/bundle/$appName
