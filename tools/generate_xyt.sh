#!/usr/bin/env bash

A=$1

# convert images to grayscale
python3 minutia.py g -f ./images/"$A".JPEG -o gs_"$A".JPEG

./install/mindtct -m1 gs_"$A".JPEG tmp
mv tmp.xyt ../test/"$A".xyt
rm -rf gs_"$A".JPEG
