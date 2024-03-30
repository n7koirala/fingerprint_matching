cmake_minimum_required(VERSION 3.10)
project(FingerprintMatching VERSION 1.0)

# Set the C++ standard to C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Add definitions and compiler options
add_definitions(-DOPENFHE_VERSION=1.0.3 -DMATHBACKEND=4)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -Wno-parentheses -fopenmp")

# Include directories
include_directories(
    ${PROJECT_SOURCE_DIR}/include
    /usr/local/include/openfhe/core
    /usr/local/include/openfhe/pke
    /usr/local/include/openfhe/
)

# Source files
add_executable(FingerprintMatching
	  src/main.cpp
    src/openFHE_wrapper.cpp
 # add other source files here
)

# Specify the path to the OpenFHE libraries
link_directories(/usr/local/lib)

# Link the OpenFHE libraries along with the C++ filesystem library
target_link_libraries(FingerprintMatching
    ${CMAKE_DL_LIBS}
    stdc++fs
    OPENFHEcore
    OPENFHEpke
    OPENFHEpke_static
    OPENFHEcore_static
)
