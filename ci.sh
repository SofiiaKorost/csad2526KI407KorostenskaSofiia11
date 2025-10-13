#!/usr/bin/env bash
set -euo pipefail

# Print a message with a timestamp
echo_msg() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Step 1: Create build directory
echo_msg "Creating build directory..."
mkdir -p build
cd build

echo_msg "Configuring project with CMake..."
if ! cmake ..; then
    echo_msg "CMake configuration failed!" >&2
    exit 1
fi

echo_msg "Building project..."
if ! cmake --build .; then
    echo_msg "Build failed!" >&2
    exit 2
fi

echo_msg "Running tests with CTest..."
if ! ctest --output-on-failure; then
    echo_msg "Tests failed!" >&2
    exit 3
fi

echo_msg "All steps completed successfully."
