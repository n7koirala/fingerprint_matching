# Fingerprint Matching README

## Introduction

Welcome to the **Fingerprint Matching** project! This repository contains a comprehensive implementation of fingerprint matching algorithms. The primary goal of this project is to provide a robust framework for the comparison and matching of fingerprint data using advanced cryptographic techniques, specifically homomorphic encryption.

## Features

- **Homomorphic Encryption**: Leverages the OpenFHE library to perform secure computations on encrypted data.
- **Biometric Standards**: Complies with standards set by the National Institute of Standards and Technology (NIST).
- **Image Processing**: Includes utilities for image compression and decompression using various algorithms.
- **Parallel Processing**: Supports parallel search and processing to enhance performance.
- **Error Handling**: Comprehensive error handling mechanisms to ensure robustness.

## Requirements

- **C++ Compiler**: Ensure you have a modern C++ compiler that supports C++17 or later.
- **CMake**: Build system generator (version 3.10 or later).
- **OpenFHE Library**: For homomorphic encryption operations.
- **Standard Libraries**: Standard libraries for image processing and mathematical computations.

## Installation

### Step-by-Step Guide

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/n7koirala/fingerprint_matching.git
    cd fingerprint_matching
    ```

2. **Install Dependencies**:
    Ensure you have all necessary dependencies installed:
    - OpenFHE
    - CMake
    - Standard C++ libraries

3. **Build the Project**:
    ```bash
    mkdir build
    cd build
    cmake ..
    make
    ```

## Usage

To run the fingerprint matching application, use the following command in your terminal:

```bash
./build/fingerprint_matching [fingerprint file 1.xyt] [fingerprint file 2.xyt]
```

For instance, try:
```bash
./fingerprint_matching ../test/6.xyt ../test/6.xyt
```


This will execute the main application, showcasing the fingerprint matching operations including encryption, matching, and decryption steps.


### Generating .xyt files
Look at `README.md` in the `tools` directory for more details.

## Configuration

### Parameters

The application can be configured using various parameters defined in the source code. Key parameters include:

- **Multiplicative Depth**: Set the depth of multiplicative operations.
- **Scaling Mod Size**: Configure the size for scaling modulus.
- **Batch Size**: Determine the batch size for encoding parameters.

### Example Configuration

```cpp
CCParams<CryptoContextCKKSRNS> parameters;
parameters.SetMultiplicativeDepth(15);
parameters.SetScalingModSize(45);
parameters.SetBatchSize(32768);
```

## Contributing

We welcome contributions from the community to enhance the functionality and performance of the fingerprint matching project. Here’s how you can contribute:

1. **Fork the Repository**: Click on the fork button at the top right of the repository page.
2. **Create a Branch**: Create a new branch for your feature or bugfix.
    ```bash
    git checkout -b feature-name
    ```
3. **Make Changes**: Implement your changes in the new branch.
4. **Submit a Pull Request**: Push your changes to your forked repository and submit a pull request to the main repository.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

```text
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

This README provides a comprehensive guide to understanding, installing, and contributing to the fingerprint matching project. For more detailed information, please refer to the source code and comments within the repository.
