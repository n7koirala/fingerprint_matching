# bozorth_tools

This repository will hold python scripts to help demonstrate how the bozorth algorithm works with images. 


### Setup
On linux/MacOS run ```./setup.sh``` to configure and compile bozorth3 and mindtct from nbis.

### Examples
After configuring binaries for nbis, run ```./example.sh``` on linux/MacOS and ```./windows_example.sh``` on Windows.

### Generate .xyt
Run ```./generate_xyt.sh [image number]``` to generate new .xyt files from the images directory. 
```./generate_xyt.sh 0``` will create 0.xyt in the test directory.
