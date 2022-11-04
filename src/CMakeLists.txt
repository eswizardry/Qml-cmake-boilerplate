cmake_minimum_required(VERSION 3.13)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (WIN32)
    set(ICON_FILE "win/app_icon.rc")
    if (MSVC)
      # do MSVC specific things
    else()
        set(LINK_FLAGS -Wl, -subsystem, windows) # Control availability of a console
        set(CMAKE_CXX_FLAGS "-Wall -Werror -std=c++17 -fstrict-aliasing -pedantic-errors -pedantic -Wno-deprecated-declarations -Wno-unused-variable -static-libstdc++") # https://stackoverflow.com/questions/69773877/getting-throw-bad-array-new-lengthv-when-trying-to-use-stdvectorpush-back
    endif()
elseif(UNIX)
    if (ANDROID)
        # Android
    elseif(APPLE)
        # OS X
        set(ICON_FILE "osx/app_icon.icns")
    endif()
endif()



find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Quick)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Widgets Qml Quick QuickControls2 REQUIRED)

include_directories(${QtWidgets_INCLUDE_DIRS} ${QtQuick_INCLUDE_DIRS} ${QtQml_INCLUDE_DIRS})
add_definitions(${QtWidgets_DEFINITIONS} ${QtQml_DEFINITIONS} ${${QtQuick_DEFINITIONS}})

#target_include_directories(spdlog PUBLIC "../thirdparty/spdlog/include/spdlog/")

qt_add_resources(QT_RESOURCES ./resources.qrc)
qt_add_resources(QT_RESOURCES ./assets/fonts/fonts.qrc)
qt_add_resources(QT_RESOURCES ./qml/qml.qrc)
qt_add_resources(QT_RESOURCES ./qml/component/component.qrc)
qt_add_resources(QT_RESOURCES ./thirdparty/thirdparty.qrc)

# Directory with the target source
#add_library(utils "")
#add_subdirectory(utility)

if(NOT DEFINED HEADERS)
    file(GLOB HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/cpp/*.h)
endif()

if(NOT DEFINED SOURCES)
    file(GLOB SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/cpp/*.cpp)
endif()

if (CMAKE_BUILD_TYPE STREQUAL Debug)

endif()

set(LIB_INCLUDE_DIR "cpp/" "thirdparty/spdlog/include/")

# All sources that also need to be tested in unit tests go into a static library
add_library(${PROJECT_NAME}_lib STATIC ${HEADERS} ${SOURCES} )
target_compile_definitions(${PROJECT_NAME}_lib PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:DEBUG>)
target_include_directories(${PROJECT_NAME}_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR} ${LIB_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME}_lib PRIVATE            
    spdlog
    $<TARGET_OBJECTS:SortFilterProxyModel>
    platform
    Qt::Core
    Qt::Quick
    Qt::Widgets
    Qt::Qml
    Qt::Quick
    Qt::QuickControls2
    )

add_executable(${PROJECT_NAME} ${QT_RESOURCES} ${ICON_FILE})
target_link_libraries(${PROJECT_NAME} ${PROJECT_NAME}_lib)
