# Maintainer: r4v3n6101

pkgname=xash3d-fwgs-git
pkgver=r5782.8259525e
pkgrel=1
pkgdesc="A custom GoldSrc engine implementation"
arch=('x86_64' 'aarch64')
url="http://xash.su/"
license=('GPL3')
depends=('freetype2' 'fontconfig' 'libpulse' 'sdl2')
makedepends=('gcc' 'gcc-libs' 'make' 'binutils' 'python')
provides=('xash3d')
conflicts=('xash3d-hlsdk' 'xash3d-git')
options=('!debug' 'strip')
source=("$pkgname::git+https://github.com/FWGS/xash3d-fwgs"
        "xash3d")
sha256sums=('SKIP'
            'SKIP')

pkgver() {
    cd $srcdir/$pkgname
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

prepare() {
    cd $srcdir/$pkgname
    git submodule update --init --recursive
    ./waf configure -8 -T release --enable-lto --enable-poly-opt --enable-bundled-deps
}

build() {
    cd $srcdir/$pkgname
    ./waf build
}

package() {
    cd $srcdir
    install -Dm 755 "xash3d" "${pkgdir}/usr/bin/xash3d"
    cd $pkgname
    ./waf install --strip --destdir="${pkgdir}/opt/xash3d/"
    install -Dm 755 "3rdparty/vgui_support/vgui-dev/lib/vgui.so" "${pkgdir}/opt/xash3d/vgui.so"
    install -Dm644 "game_launch/icon-xash-material.png" "${pkgdir}/usr/share/pixmaps/xash-material.png"
}
