# Fingerprint Matching Prototype
This repository hosts the prototype of an privacy preserving fingerprint matching system using OpenFHE.


### Building and Running
Make a `build` directory to build the executables.

```
mkdir build
cd build
cmake ..
make
```

This will build the executable FingerprintMatching. 
`./FingerprintMatching [fingerprint file 1.xyt] [fingerprint file 2.xyt]`

Try this as an example:
```
./FingerprintMatching ../test/6.xyt ../test/6.xyt
```

### Generating .xyt files
Look at `README.md` in the `tools` directory for more details.
