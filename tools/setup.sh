#!/usr/bin/env bash

# This script will set up mindtct and bozorth3 to generate files necessary for bozorth demonstration 
#
#
# Create an install dir
mkdir -p install

DIR_MAIN="$(pwd)/nbis"
DIR_INSTALL="$(pwd)/install"
RULES="$(pwd)/nbis/rules.mak"


cd nbis
cat rules.mak.src | sed 's,SED_DIR_MAIN,'$DIR_MAIN',' > temp1.mak
cat temp1.mak | sed 's,SED_FINAL_INSTALLATION_STRING,'$DIR_INSTALL',' > rules.mak

rm -rf temp1.mak

cd bozorth3
cat p_rules.mak.src | sed 's,SED_RULES_STRING,'$RULES',' > p_rules.mak
make


cd ../mindtct
cat p_rules.mak.src | sed 's,SED_RULES_STRING,'$RULES',' > p_rules.mak
make

cd .. # /nbis/
cp bozorth3/bin/bozorth3 ../install/bozorth3
cp mindtct/bin/mindtct ../install/mindtct

rm -rf ../install/bin ../install/lib
