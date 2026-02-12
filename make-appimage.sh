#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q xash3d-fwgs-git | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/FWGS/xash3d-fwgs/refs/heads/master/game_launch/icon-xash-material.png
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /opt/xash3d/*
mv -v /opt/xash3d/extras.pk3 ./AppDir/bin
#mv /opt/xash3d/* ./AppDir/bin
#echo 'SHARUN_WORKING_DIR=${SHARUN_DIR}/bin' >> ./AppDir/.env

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
