# 3rd party tools
find_package(Qt5 COMPONENTS core Widgets Qml Quick QuickControls2 REQUIRED)
include_directories(${Qt5Widgets_INCLUDE_DIRS} ${Qt5Quick_INCLUDE_DIRS} ${QtQml_INCLUDE_DIRS})
add_definitions(${Qt5Widgets_DEFINITIONS} ${QtQml_DEFINITIONS} ${${Qt5Quick_DEFINITIONS}})

qt5_add_resources(QT_RESOURCES ../qml/qml.qrc)
qt5_add_resources(QT_RESOURCES ../assets/assets.qrc)
qt5_add_resources(QT_RESOURCES ../translations/translations.qrc)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (MSVC)
  # do MSVC specific things
else()
  set(CMAKE_CXX_FLAGS "-Wall -Werror -std=c++11 -fstrict-aliasing -pedantic-errors -pedantic -Wno-deprecated-declarations -Wno-unused-variable")
endif()

# Directory with the target source
#add_library(utils "")
#add_subdirectory(utility)


if(NOT DEFINED HEADERS)
    file(GLOB HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.h)
endif()

if(NOT DEFINED SOURCES)
    file(GLOB SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
endif()

source_group("Header Files" FILES ${HEADERS})
source_group("Source Files" FILES ${SOURCES})

# All sources that also need to be tested in unit tests go into a static library
#add_library(app_lib STATIC ${HEADERS} ${SOURCES} ${QT_RESOURCES})
#target_include_directories(app_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_executable(${PROJECT} ${HEADERS} ${SOURCES} ${QT_RESOURCES})
target_link_libraries(${PROJECT}
    Qt5::Core
    Qt5::Widgets
    Qt5::Qml
    Qt5::Quick
    Qt5::QuickControls2
    )

