cmake_minimum_required(VERSION 2.6)

project(test)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../")
set(FINDPHP_DEBUG ON)
find_package(PHP REQUIRED)
