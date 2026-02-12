#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/FWGS/xash3d-fwgs/refs/heads/master/game_launch/icon-xash-material.png
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /opt/xash3d/*
mv -v /opt/xash3d/extras.pk3 ./AppDir/bin

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
