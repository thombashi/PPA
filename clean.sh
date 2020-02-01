#!/bin/bash

set -eux

if [ $# -ne 1 ]; then
    echo "ERROR: requires a package name" 1>&2
    exit 1
fi

PKG=$1

if [ ! -e "$PKG" ]; then
    echo "ERROR: package not found ${PKG}" 1>&2
    exit 2
fi

PKG_LOWER=${PKG,,}

cd "$PKG"
rm -rf ${PKG}-*.*.*/ ${PKG_LOWER}-*.*.*/
rm -f \
    ./*.build* \
    ./*.changes \
    ./*.deb \
    ./*.debian.tar.xz \
    ./*.dsc
