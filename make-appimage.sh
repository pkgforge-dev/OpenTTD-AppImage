#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q openttd | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook:sdl-soundfonts.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/256x256/apps/openttd.png
export DESKTOP=/usr/share/applications/openttd.desktop
export STARTUPWMCLASS=openttd
export USE_HOST_DRIVERS_EXPERIMENTAL=1
export DEPLOY_PIPEWIRE=1 # needed for libfluidsynth

# Deploy dependencies
quick-sharun /usr/bin/openttd /usr/share/openttd

# Turn AppDir into AppImage
quick-sharun --make-appimage
