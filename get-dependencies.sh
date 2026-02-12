#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    fontconfig \
    libdecor \
    python   \
    sdl2
    

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package

# If the application needs to be manually built that has to be done down here
echo "Making nightly build of Xash3D-FWGS..."
echo "---------------------------------------------------------------"
REPO="https://github.com/FWGS/xash3d-fwgs"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --recursive --depth 1 "$REPO" ./xash3d-fwgs
echo "$VERSION" > ~/version

mkdir -p /opt/xash3d
cd ./xash3d-fwgs
./waf configure -8 -T release --enable-lto --enable-poly-opt
./waf build
mv -v 3rdparty/vgui_support/vgui-dev/lib/vgui.so /opt/xash3d
cd build
mv -v game_launch/xash3d /opt/xash3d
mv -v filesystem/filesystem_stdio.so /opt/xash3d
mv -v engine/libxash.so /opt/xash3d
mv -v 3rdparty/mainui/libmenu.so /opt/xash3d
mv -v ref/gl/libref_gl.so /opt/xash3d
mv -v ref/soft/libref_soft.so /opt/xash3d
