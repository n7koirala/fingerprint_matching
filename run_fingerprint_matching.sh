#!/bin/bash
# log messages to help users understand the script's progress and outcomes.
echo ""
echo "================= Secure Fingerprint Matching ====================="
echo ""
echo "Crypto context, parameters and keys initialized for FHE." 
echo "Security level: 128-bits" 
echo ""
echo "Encoding the fingerprint data." 
echo "Encrypting the fingerprint data." 
echo ""
echo "================= Running Homomorphic Matching ====================="
echo ""
echo "Computing the distances.." 
echo "Computing the angles.."  


# Run the FingerprintMatching command with the provided arguments and redirect output to a file
./FingerprintMatching ../test/6.xyt ../test/6.xyt ../test/6.xyt ../test/7.xyt ../test/6.xyt ../test/5.xyt ../test/6.xyt ../test/7.xyt ../test/6.xyt ../test/8.xyt ../test/6.xyt ../test/9.xyt ../test/6.xyt ../test/15.xyt ../test/6.xyt ../test/21.xyt ../test/6.xyt ../test/23.xyt ../test/6.xyt ../test/32.xyt > output.txt

echo "Completed."
echo ""

# Set the threshold
threshold=115

# Read the output file and check if the values crossed the threshold
echo "================= Interpreting Results ====================="
echo ""
while IFS= read -r line
do
  if [ "$line" -gt "$threshold" ]; then
    echo "match"
  else
    echo "no match"
  fi
done < output.txt
echo ""
echo "================= END ====================="
