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

# Comment this out if you need an AUR package
#make-aur-package openttd-openmsx

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
echo "Getting OpenTTD-openmsx..."
echo "---------------------------------------------------------------"
VERSION=0.4.2
https://cdn.openttd.org/openmsx-releases/${VERSION}/openmsx-${VERSION}-all.zip

bsdtar -xvf openmsx-${VERSION}-all.zip
