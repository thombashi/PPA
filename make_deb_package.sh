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
VERSION=$(python -c "import ${PKG_LOWER}; print(${PKG_LOWER}.__version__)")
TAG=v${VERSION}
ARCHIVE=${TAG}.tar.gz
ORIG_ARCHIVE=${PKG_LOWER}_${VERSION}.orig.tar.gz
SRC_DIR=${PKG}-${VERSION}
SRC_DIR_LOWER=${PKG_LOWER}-${VERSION}

# initialize
cd "${PKG}"
rm -rf "${SRC_DIR}" "${SRC_DIR_LOWER}"

# fetch source code
if [ ! -e "$ORIG_ARCHIVE" ]; then
    rm -f ${PKG_LOWER}_*
    wget https://github.com/thombashi/${PKG}/archive/${ARCHIVE}
    mv "${ARCHIVE}" "${ORIG_ARCHIVE}"
fi

tar -xf "${ORIG_ARCHIVE}"
mv "${SRC_DIR}" "${SRC_DIR_LOWER}"

# build
cp -ar debian/ "${SRC_DIR_LOWER}/"
cd "${SRC_DIR_LOWER}/debian"
debuild -S -sa
