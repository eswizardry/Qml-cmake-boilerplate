cmake_minimum_required (VERSION 3.13)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

if (MSVC)
  # do MSVC specific things
else()
  set(CMAKE_CXX_FLAGS "-Wall -Werror -std=c++11 -fstrict-aliasing -pedantic-errors -pedantic -Wno-deprecated-declarations -Wno-unused-variable")
endif()

find_package(Qt5 COMPONENTS Test REQUIRED)

#############################
## unit tests
#############################
set(TEST_SOURCES
    "main.cpp"
    "test_factorial.cpp"
    )
add_executable(${PROJECT_NAME}_test ${TEST_SOURCES})
target_link_libraries(${PROJECT_NAME}_test Catch Trompeloeil)
target_link_libraries(${PROJECT_NAME}_test Qt5::Test)
target_link_libraries(${PROJECT_NAME}_test ${PROJECT_NAME}_lib)
enable_testing()

add_test(NAME UnitTests COMMAND ${PROJECT_NAME}_test)
