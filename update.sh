#!/usr/bin/env bash

appName=flutter-gpio
target=linux-arm64

newestRelease=$(curl https://api.github.com/repos/felixholfelder/$appName/releases/latest | grep tag_name | sed -E 's/.*"([^"]+)".*/\1/')
echo "Neueste Version: $newestRelease"

currRelease=$(git rev-parse --abbrev-ref HEAD)
echo "Aktuelle Version: $currRelease"

if [ -"$newestRelease" != "$currRelease" ]; then
    rm -rf $appName
    git clone https://github.com/felixholfelder/$appName.git --branch "$newestRelease"

    flutter build linux --release --target-platform $target
fi

./$appName/build/linux/$target/release/bundle/$appName

read test