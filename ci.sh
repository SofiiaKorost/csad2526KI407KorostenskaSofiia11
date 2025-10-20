#!/usr/bin/env bash
set -euo pipefail

# Print a message with a timestamp
echo_msg() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Step 1: Clean old build directory
echo_msg "Cleaning old build directory..."
rm -rf build

# Step 2: Create build directory
echo_msg "Creating build directory..."
mkdir -p build
cd build

# Step 3: Configure with CMake
echo_msg "Configuring project with CMake..."
if ! cmake ..; then
    echo_msg "CMake configuration failed!" >&2
    exit 1
fi

# Step 4: Build project
echo_msg "Building project..."
if ! cmake --build .; then
    echo_msg "Build failed!" >&2
    exit 2
fi

# Step 5: Run tests
echo_msg "Running tests with CTest..."
if ! ctest --output-on-failure; then
    echo_msg "Tests failed!" >&2
    exit 3
fi

echo_msg "All steps completed successfully."

