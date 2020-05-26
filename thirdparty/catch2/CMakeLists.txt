set(PROJECT "Catch2")
project(${PROJECT})

# Header only library, therefore INTERFACE
add_library(catch2 INTERFACE)

# INTERFACE targets only have INTERFACE properties
target_include_directories(catch2 INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_compile_features(catch2 INTERFACE cxx_std_11)
