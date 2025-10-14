@echo off
echo [INFO] Running CI on Windows

if not exist build mkdir build
cd build

echo [INFO] Configuring project with CMake...
cmake ..
if errorlevel 1 (
    echo [ERROR] CMake configuration failed!
    exit /b 1
)

echo [INFO] Building project...
cmake --build .
if errorlevel 1 (
    echo [ERROR] Build failed!
    exit /b 2
)

echo [INFO] Running tests with CTest...
ctest --output-on-failure
if errorlevel 1 (
    echo [ERROR] Tests failed!
    exit /b 3
)

echo [INFO] All steps completed successfully.
