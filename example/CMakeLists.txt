cmake_minimum_required(VERSION 2.8)
project(my_extension)

set(PROJECT_NAME  "my_extension")
set(PROJECT_BRIEF "My PHP extension")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../")
find_package(PHP REQUIRED)

# Build
set(SRC my_extension.cpp)
include_directories(${PROJECT_NAME} ${PHP_INCLUDE_DIRS})
add_library(${PROJECT_NAME} SHARED ${SRC})
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "") # Remove "lib" prefix from libmy_extension.so

# Install/package
install(TARGETS ${PROJECT_NAME} DESTINATION ${PHP_EXTENSIONS_DIR})

# Test
enable_testing()
add_test(NAME my_extension COMMAND ${PHP_EXECUTABLE} -dextension=${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.so ${CMAKE_CURRENT_SOURCE_DIR}/my_extension.php)

# Package
set(CPACK_PACKAGE_NAME "php${PHP_VERSION_MAJOR}-my_extension")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "My PHP extension from cmake")
set(CPACK_PACKAGE_VENDOR "Me")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/../LICENSE.md")
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")

set(CPACK_GENERATOR "DEB")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Jerry Jacobs") # required

include(CPack) # must come last
