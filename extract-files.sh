#!/bin/sh

VENDOR=lge
DEVICE=hammerhead

echo "Please wait..."
wget -nc -q https://dl.google.com/dl/android/aosp/hammerhead-lrx22c-factory-0f9eda1b.tgz
tar zxf hammerhead-lrx22c-factory-0f9eda1b.tgz
rm hammerhead-lrx22c-factory-0f9eda1b.tgz
cd hammerhead-lrx22c
unzip image-hammerhead-lrx22c.zip
cd ../
./simg2img hammerhead-lrx22c/system.img system.ext4.img
mkdir system
sudo mount -o loop -t ext4 system.ext4.img system

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary
rm -rf $BASE/*

for FILE in `cat proprietary-blobs.txt | grep -v ^# | grep -v ^$ | sed -e 's#^/system/##g'| sed -e "s#^-/system/##g"`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    echo "cp $FILE $BASE/$FILE"
    cp system/$FILE $BASE/$FILE

done

./setup-makefiles.sh

sudo umount system
rm -rf system
rm -rf hammerhead-lrx22c
rm system.ext4.img
