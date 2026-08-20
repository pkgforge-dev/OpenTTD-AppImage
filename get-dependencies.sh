#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    openttd         \
    openttd-opengfx \
    openttd-opensfx \
    pipewire-audio  \
    pipewire-jack

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

echo "Getting OpenTTD-OpenMSX..."
echo "---------------------------------------------------------------"
VERSION=0.4.2
wget https://cdn.openttd.org/openmsx-releases/${VERSION}/openmsx-${VERSION}-all.zip

mkdir -p ./AppDir/share/openttd/gm
bsdtar -xOf openmsx-${VERSION}-all.zip openmsx-${VERSION}.tar | bsdtar -xvf - --include='openmsx-0.4.2/*.mid' --include='openmsx-0.4.2/openmsx.*' -C ./AppDir/share/openttd/gm --strip-components=1
