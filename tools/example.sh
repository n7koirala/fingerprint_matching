#!/usr/bin/env bash
# 
#
A="6"
B="32"

# rm -rf "$A"_minutia.JPEG "$B"_minutia.JPEG "$A".xyt "$B".xyt "$A"_pairs.txt "$B"_pairs.txt "$A"_sim.txt "$B"_sim.txt "$A"_"$B"_sim.txt 32_matches.txt
# exit
# assuming ./setup was already ran

# convert images to grayscale
python3 minutia.py g -f ./images/"$A".JPEG -o gs_"$A".JPEG
python3 minutia.py g -f ./images/"$B".JPEG -o gs_"$B".JPEG

# compute .xyt files
./install/mindtct -m1 gs_"$A".JPEG tmp
mv tmp.xyt "$A".xyt
./install/mindtct -m1 gs_"$B".JPEG tmp
mv tmp.xyt "$B".xyt
rm -rf tmp.* gs_"$A".JPEG gs_"$B".JPEG

# run bozorth on .xty files
./install/bozorth3 "$A".xyt "$A".xyt > /dev/null
mv 32_matches.txt "$A"_pairs.txt
mv similarity_pairs.txt "$A"_sim.txt

./install/bozorth3 "$B".xyt "$B".xyt > /dev/null
mv 32_matches.txt "$B"_pairs.txt
mv similarity_pairs.txt "$B"_sim.txt

./install/bozorth3 "$A".xyt "$B".xyt > /dev/null
mv similarity_pairs.txt "$A"_"$B"_sim.txt


python3 minutia.py m -f ./images/"$A".JPEG -x "$A".xyt -o "$A"_minutia.JPEG
echo "Displaying minutia on $A.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key

python3 minutia.py m -f ./images/"$B".JPEG -x "$B".xyt -o "$B"_minutia.JPEG
echo "Displaying minutia on $B.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key


python3 minutia.py p -f "$A"_minutia.JPEG -p "$A"_pairs.txt
echo "Displaying minutia pairs on $A.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key

python3 minutia.py p -f "$B"_minutia.JPEG -p "$B"_pairs.txt
echo "Displaying minutia pairs on $B.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key


python3 minutia.py s -f ./images/"$A".JPEG -f ./images/"$A".JPEG -s "$A"_sim.txt
echo "Displaying minutia similarities on $A.JPEG and $A.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key

python3 minutia.py s -f ./images/"$B".JPEG -f ./images/"$B".JPEG -s "$B"_sim.txt
echo "Displaying minutia similarities on $B.JPEG and $B.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key

python3 minutia.py s -f ./images/"$A".JPEG -f ./images/"$B".JPEG -s "$A"_"$B"_sim.txt
echo "Displaying minutia similarities on $A.JPEG and $B.JPEG"
echo "Waiting for input to progress..."
echo ""
read -n 1 key


rm -rf ./sim_output
python3 minutia.py sm -f ./images/"$A".JPEG -f ./images/"$A".JPEG -s "$A"_sim.txt -o "$A"
echo "Displaying minutia similarities on $A.JPEG and $A.JPEG"
echo ""

python3 minutia.py sm -f ./images/"$B".JPEG -f ./images/"$B".JPEG -s "$B"_sim.txt -o "$B"
echo "Displaying minutia similarities on $B.JPEG and $B.JPEG"
echo ""

python3 minutia.py sm -f ./images/"$A".JPEG -f ./images/"$B".JPEG -s "$A"_"$B"_sim.txt -o "$A$B"
echo "Displaying minutia similarities on $A.JPEG and $B.JPEG"
echo ""

echo "Removing all temp files generated in example"
rm -rf "$A"_minutia.JPEG "$B"_minutia.JPEG "$A".xyt "$B".xyt "$A"_pairs.txt "$B"_pairs.txt "$A"_sim.txt "$B"_sim.txt "$A"_"$B"_sim.txt 32_matches.txt
exit 

# use this to generate example files for windows demonstration
cp "$A"_minutia.JPEG test/.
cp "$B"_minutia.JPEG test/.
cp "$A".xyt test/.
cp "$B".xyt test/.
cp "$A"_pairs.txt test/.
cp "$B"_pairs.txt test/.
cp "$A"_sim.txt test/.
cp "$B"_sim.txt test/.
cp "$A"_"$B"_sim.txt test/.
cp 32_matches.txt test/.
