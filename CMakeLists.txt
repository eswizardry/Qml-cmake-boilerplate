cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
set(PROJECT "Simple-cmake-boilerplate")
project(${PROJECT})

# 3rd party tools
find_package(Qt5 COMPONENTS core Widgets Qml Quick QuickControls2 REQUIRED)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_definitions(-DDEBUG)
endif()

# Directory with the third party libraries
add_subdirectory(thirdparty/catch2)
# Directory with the source code
add_subdirectory(src)
# Directory with the test
#add_subdirectory(test)
