#!/usr/bin/env bash

OSV_BASE=/opt/osv-fuzetsu
arch=x64

IMAGE_FILE="$2"
OUT_DIR="$1"
APPSRC_DIR="$OUT_DIR/appitself"
OSV_BUILD_PATH="$OSV_BASE/build/last"
SRC="$OSV_BASE"
RUN_COMMAND="$3"

cd $OSV_BASE

sed -e "s/\${APP_DIR}/$(echo $APPSRC_DIR | sed -e s/\\//\\\\\\\//g)/g" $APPSRC_DIR/usr.manifest > $OUT_DIR/app.manifest

cat $OUT_DIR/app.manifest > $OUT_DIR/manifest
mv $OUT_DIR/manifest $OUT_DIR/usr.manifest

cp "$OSV_BASE/build/release.x64/usr.img" "$IMAGE_FILE"

cd "$OSV_BASE/build/release.x64"
$SRC/scripts/upload_manifest.py -o "$IMAGE_FILE" -m "$OUT_DIR/usr.manifest"
$SRC/scripts/imgedit.py setargs "$IMAGE_FILE" "$RUN_COMMAND"
