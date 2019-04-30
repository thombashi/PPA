#!/bin/sh

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

VERSION=$(python -c "import ${PKG}; print(${PKG}.__version__)")
TAG=v${VERSION}
ARCHIVE=${TAG}.tar.gz
SRC_DIR=${PKG}-${VERSION}

# initialize
cd "$PKG"
rm -rf "${SRC_DIR}"
rm -f ${PKG}_*

# fetch source code
wget https://github.com/thombashi/${PKG}/archive/${ARCHIVE}
tar -xf "${ARCHIVE}"
mv "${ARCHIVE}" "${PKG}_${VERSION}.orig.tar.gz"

# build
cp -ar debian/ "${SRC_DIR}/"
cd "${SRC_DIR}/debian"
debuild -S -sa
