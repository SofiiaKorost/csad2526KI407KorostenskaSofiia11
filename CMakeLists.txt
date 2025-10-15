cmake_minimum_required(VERSION 3.10)
project(HelloWorld)

set(CMAKE_CXX_STANDARD 11)

add_executable(hello main.cpp)

# Google Test support
enable_testing()
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})
include_directories(${CMAKE_SOURCE_DIR})

add_executable(unit_tests tests/unit_tests.cpp math_operations.cpp)
if(UNIX)
    target_link_libraries(unit_tests ${GTEST_LIBRARIES} pthread)
else()
    target_link_libraries(unit_tests ${GTEST_LIBRARIES})
endif()
add_test(NAME unit_tests COMMAND unit_tests)

# Instructions:
# 1. Install Google Test (e.g., brew install googletest)
# 2. mkdir build && cd build
# 3. cmake ..
# 4. make
# 5. ./hello            # Run main program
# 6. ctest OR ./unit_tests   # Run tests
