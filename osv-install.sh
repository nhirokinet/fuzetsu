#!/bin/sh

echo Pressing Enter will start reinstallation, and take some time.
read dummy

rm -Rf /tmp/osv-fuzetsu
cd /tmp
git clone https://github.com/nhirokinet/osv-fuzetsu.git
cd /tmp/osv-fuzetsu
git submodule update --init --recursive
cd /tmp/osv-fuzetsu

rm -rf /opt/osv-fuzetsu
mkdir -p /opt
mv /tmp/osv-fuzetsu /opt
cd /opt/osv-fuzetsu
/opt/osv-fuzetsu/scripts/setup.py
make fs_size_mb=160 modules=java
