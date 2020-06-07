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
        set(CMAKE_CXX_FLAGS "-Wall -Werror -std=c++17 -fstrict-aliasing -pedantic-errors -pedantic -Wno-deprecated-declarations -Wno-unused-variable")
    endif()
elseif(UNIX)
    if (ANDROID)
        # Android
    elseif(APPLE)
        # OS X
        set(ICON_FILE "osx/app_icon.icns")
    endif()
endif()




find_package(Qt5 COMPONENTS core Widgets Qml Quick QuickControls2 REQUIRED)

include_directories(${Qt5Widgets_INCLUDE_DIRS} ${Qt5Quick_INCLUDE_DIRS} ${QtQml_INCLUDE_DIRS})
add_definitions(${Qt5Widgets_DEFINITIONS} ${QtQml_DEFINITIONS} ${${Qt5Quick_DEFINITIONS}})

#target_include_directories(spdlog PUBLIC "../thirdparty/spdlog/include/spdlog/")

qt5_add_resources(QT_RESOURCES ./resources.qrc)
qt5_add_resources(QT_RESOURCES ./assets/fonts/fonts.qrc)
qt5_add_resources(QT_RESOURCES ./qml/qml.qrc)
qt5_add_resources(QT_RESOURCES ./qml/component/component.qrc)
qt5_add_resources(QT_RESOURCES ./qml/soup/soup.qrc)

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

set(LIB_INCLUDE_DIR "../thirdparty/spdlog/include/spdlog/")

source_group("Header Files" FILES ${HEADERS})
source_group("Source Files" FILES ${SOURCES})

# All sources that also need to be tested in unit tests go into a static library
add_library(${PROJECT_NAME}_lib STATIC ${HEADERS} ${SOURCES})
target_compile_definitions(${PROJECT_NAME}_lib PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:DEBUG>)
target_include_directories(${PROJECT_NAME}_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR} ${LIB_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME}_lib PRIVATE
    spdlog
    $<TARGET_OBJECTS:SortFilterProxyModel>
    Qt5::Core
    Qt5::Quick
    Qt5::Widgets
    Qt5::Qml
    Qt5::Quick
    Qt5::QuickControls2
    )

add_executable(${PROJECT_NAME} ${QT_RESOURCES} ${ICON_FILE})
target_link_libraries(${PROJECT_NAME} ${PROJECT_NAME}_lib)
