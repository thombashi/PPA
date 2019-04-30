#!/bin/sh

set -eux

PKG=mbstrdecoder

VERSION=$(python -c "import ${PKG}; print(${PKG}.__version__)")
TAG=v${VERSION}
ARCHIVE=${TAG}.tar.gz
SRC_DIR=${PKG}-${VERSION}

wget https://github.com/thombashi/${PKG}/archive/${ARCHIVE}
tar -xvf ${ARCHIVE}
mv ${ARCHIVE} ${PKG}_${VERSION}.orig.tar.gz
cp -ar debian/ ${SRC_DIR}/
cd ${SRC_DIR}/debian
debuild -S -sa
