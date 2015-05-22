#!/bin/sh

VENDOR=lge
DEVICE=hammerhead

echo "Please wait..."
wget -nc -q https://dl.google.com/dl/android/aosp/hammerhead-lmy48b-factory-596bb9c1.tgz
tar zxf hammerhead-lmy48b-factory-596bb9c1.tgz
rm hammerhead-lmy48b-factory-596bb9c1.tgz
cd hammerhead-lmy48b
unzip image-hammerhead-lmy48b.zip
cd ../
./simg2img hammerhead-lmy48b/system.img system.ext4.img
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
rm -rf hammerhead-lmy48b
rm system.ext4.img
