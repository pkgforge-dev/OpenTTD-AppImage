#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q openttd | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/256x256/apps/openttd.png
export DESKTOP=/usr/share/applications/openttd.desktop
export STARTUPWMCLASS=openttd
export DEPLOY_OPENGL=1
export DEPLOY_PIPEWIRE=1 # needed for libfluidsynth

# Deploy dependencies
quick-sharun /usr/bin/openttd /usr/share/openttd

mkdir -p ./AppDir/share/soundfonts
wget https://raw.githubusercontent.com/Jacalz/fluid-soundfont/master/SF3/FluidR3.sf3 -O ./AppDir/share/soundfonts/FluidR3.sf3

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
quick-sharun --simple-test ./dist/*.AppImage
