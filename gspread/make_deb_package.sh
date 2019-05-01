#!/bin/bash

set -eux


PKG=gspread
AUTHOR=burnash

PKG_LOWER=${PKG,,}
VERSION=$(python -c "import ${PKG_LOWER}; print(${PKG_LOWER}.__version__)")
TAG=v${VERSION}
ARCHIVE=${TAG}.tar.gz
ORIG_ARCHIVE=${PKG_LOWER}_${VERSION}.orig.tar.gz
SRC_DIR=${PKG}-${VERSION}
SRC_DIR_LOWER=${PKG_LOWER}-${VERSION}

# initialize
rm -rf "${SRC_DIR}" "${SRC_DIR_LOWER}"

# fetch source code
if [ ! -e "$ORIG_ARCHIVE" ]; then
    rm -f ${PKG_LOWER}_*
    wget https://github.com/${AUTHOR}/${PKG}/archive/${ARCHIVE}
    mv "${ARCHIVE}" "${ORIG_ARCHIVE}"
fi

tar -xf "${ORIG_ARCHIVE}"
if [ "${SRC_DIR}" != "${SRC_DIR_LOWER}" ]; then
    mv "${SRC_DIR}" "${SRC_DIR_LOWER}"
fi

# build
cp -ar debian/ "${SRC_DIR_LOWER}/"
cd "${SRC_DIR_LOWER}/debian"
debuild -S -sa
