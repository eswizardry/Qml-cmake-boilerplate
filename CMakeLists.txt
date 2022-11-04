cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
#set(CMAKE_PREFIX_PATH C:\\Qt\\5.13.2\\mingw73_64)

project("Qml-cmake-boilerplate" LANGUAGES CXX)
enable_testing()

add_subdirectory(src)
add_subdirectory(test)
add_subdirectory(src/cpp/platform)

add_subdirectory(thirdparty/catch)
add_subdirectory(thirdparty/trompeloeil)
add_subdirectory(thirdparty/spdlog)
add_subdirectory(thirdparty/SortFilterProxyModel)

