#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q xash3d-fwgs-git | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/pixmaps/xash-material.png
export DESKTOP=/usr/share/applications/xash3d.desktop
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/xash3d /opt/xash3d/*
#mv /opt/xash3d/* ./AppDir/bin
#echo 'SHARUN_WORKING_DIR=${SHARUN_DIR}/bin' >> ./AppDir/.env

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
