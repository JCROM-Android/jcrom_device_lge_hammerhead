#!/bin/sh

VENDOR=lge
DEVICE=hammerhead

echo "Please wait..."
wget -nc -q http://storage.googleapis.com/androiddevelopers/finalpreview/hammerhead-lpx13d-preview-f7596f51.tgz
tar zxf hammerhead-lpx13d-preview-f7596f51.tgz
rm hammerhead-lpx13d-preview-f7596f51.tgz
cd hammerhead-lpx13d
unzip image-hammerhead-lpx13d.zip
cd ../
./simg2img hammerhead-lpx13d/system.img system.ext4.img
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
rm -rf hammerhead-lpx13d
rm system.ext4.img
