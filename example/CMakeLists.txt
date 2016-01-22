cmake_minimum_required(VERSION 2.8)
project(my_extension)

set(PROJECT_NAME  "my_extension")
set(PROJECT_BRIEF "Example PHP extension")

enable_testing()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../")

message(${CMAKE_MODULE_PATH})

find_package(PHP REQUIRED)

set(SRC my_extension.cpp)

include_directories(${PROJECT_NAME} ${PHP_INCLUDE_DIRS})
add_library(${PROJECT_NAME} SHARED ${SRC})
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "") # Remove "lib" prefix from libmy_extension.so

add_test(NAME my_extension COMMAND ${PHP_EXECUTABLE} -dextension=${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.so ${CMAKE_CURRENT_SOURCE_DIR}/my_extension.php)
