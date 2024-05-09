#!/usr/bin/env bash
# 
#
A="6"
B="32"

# assuming ./setup was already ran

# convert images to grayscale
# python minutia.py g -f ./images/"$A".JPEG -o gs_"$A".JPEG
# python minutia.py g -f ./images/"$B".JPEG -o gs_"$B".JPEG

# compute .xyt files
cp ./test/"$A".xyt .
cp ./test/"$B".xyt .

# run bozorth on .xty files
cp ./test/"$A"_pairs.txt .
cp ./test/"$A"_sim.txt .
cp ./test/"$B"_pairs.txt .
cp ./test/"$B"_sim.txt .
cp ./test/"$A"_"$B"_sim.txt .

python minutia.py m -f ./images/"$A".JPEG -x "$A".xyt -o "$A"_minutia.JPEG
echo "Displaying minutia on $A.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key

python minutia.py m -f ./images/"$B".JPEG -x "$B".xyt -o "$B"_minutia.JPEG
echo "Displaying minutia on $B.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key


python minutia.py p -f "$A"_minutia.JPEG -p "$A"_pairs.txt
echo "Displaying minutia pairs on $A.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key

python minutia.py p -f "$B"_minutia.JPEG -p "$B"_pairs.txt
echo "Displaying minutia pairs on $B.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key


python minutia.py s -f ./images/"$A".JPEG -f ./images/"$A".JPEG -s "$A"_sim.txt
echo "Displaying minutia similarities on $A.JPEG and $A.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key

python minutia.py s -f ./images/"$B".JPEG -f ./images/"$B".JPEG -s "$B"_sim.txt
echo "Displaying minutia similarities on $B.JPEG and $B.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key

python minutia.py s -f ./images/"$A".JPEG -f ./images/"$B".JPEG -s "$A"_"$B"_sim.txt
echo "Displaying minutia similarities on $A.JPEG and $B.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key


rm -rf ./sim_output
python minutia.py sm -f ./images/"$A".JPEG -f ./images/"$A".JPEG -s "$A"_sim.txt -o "$A"
echo "Displaying minutia similarities on $A.JPEG and $A.JPEG"
echo ""

python minutia.py sm -f ./images/"$B".JPEG -f ./images/"$B".JPEG -s "$B"_sim.txt -o "$B"
echo "Displaying minutia similarities on $B.JPEG and $B.JPEG"
echo ""

python minutia.py sm -f ./images/"$A".JPEG -f ./images/"$B".JPEG -s "$A"_"$B"_sim.txt -o "$A$B"
echo "Displaying minutia similarities on $A.JPEG and $B.JPEG"
echo ""

echo "Removing all temp files generated in example"
rm -rf "$A"_minutia.JPEG "$B"_minutia.JPEG "$A".xyt "$B".xyt "$A"_pairs.txt "$B"_pairs.txt "$A"_sim.txt "$B"_sim.txt "$A"_"$B"_sim.txt 32_matches.txt
