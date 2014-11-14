#!/bin/sh

VENDOR=lge
DEVICE=hammerhead

echo "Please wait..."
wget -nc -q https://dl.google.com/dl/android/aosp/hammerhead-lrx21o-factory-01315e08.tgz
tar zxf hammerhead-lrx21o-factory-01315e08.tgz
rm hammerhead-lrx21o-factory-01315e08.tgz
cd hammerhead-lrx21o
unzip image-hammerhead-lrx21o.zip
cd ../
./simg2img hammerhead-lrx21o/system.img system.ext4.img
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
rm -rf hammerhead-lrx21o
rm system.ext4.img
