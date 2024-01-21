# SPDX-FileCopyrightText: 2024 Paul Colby <git@colby.id.au>
# SPDX-License-Identifier: BSD-3-Clause

# \todo Document.
# \todo require min cmake version

# Begin with some helpful debug messages.
list(APPEND CMAKE_MESSAGE_INDENT "${CMAKE_FIND_PACKAGE_NAME}: ")
set(CMAKE_MESSAGE_LOG_LEVEL DEBUG)
message(DEBUG "CMAKE_FIND_PACKAGE_NAME=${CMAKE_FIND_PACKAGE_NAME}")
foreach(name REQUIRED;QUIETLY;REGISTRY_VIEW;VERSION;VERSION_EXACT;COMPONENTS)
  message(DEBUG "${CMAKE_FIND_PACKAGE_NAME}_FIND_${name}=${${CMAKE_FIND_PACKAGE_NAME}_FIND_${name}}")
endforeach()

# Detect the QT_INSTALL_DOCS path (via qtpaths or qmake).
unset(_reason)
if(NOT QT_INSTALL_DOCS)
  if(QT_VERSION VERSION_GREATER_EQUAL 6.2.0 AND TARGET Qt${QT_VERSION_MAJOR}::qtpaths)
    message(DEBUG "Fetching location of imported Qt${QT_VERSION_MAJOR}::qtpaths command")
    get_target_property(_queryCommand Qt${QT_VERSION_MAJOR}::qtpaths LOCATION)
  elseif(TARGET Qt${QT_VERSION_MAJOR}::qmake)
    message(DEBUG "Fetching location of imported Qt${QT_VERSION_MAJOR}::qmake command")
    get_target_property(_queryCommand Qt${QT_VERSION_MAJOR}::qmake LOCATION)
  else()
    set(_reason "Neither qtpaths nor qmake available")
    unset(_queryCommand)
  endif()
  if (_queryCommand)
    message(DEBUG "Fetching QT_INSTALL_DOCS from ${_queryCommand}")
    execute_process(
      COMMAND "${_queryCommand}" -query QT_INSTALL_DOCS
      RESULT_VARIABLE _commandResult
      OUTPUT_VARIABLE _commandOutput
      ERROR_VARIABLE _commandError
      OUTPUT_STRIP_TRAILING_WHITESPACE
      ERROR_STRIP_TRAILING_WHITESPACE)
    message(DEBUG "${_queryCommand} result: ${_commandResult}")
    message(DEBUG "${_queryCommand} output: ${_commandOutput}")
    message(DEBUG "${_queryCommand} error: ${_commandError}")
    if(_commandResult EQUAL 0)
      set(QT_INSTALL_DOCS "${_commandOutput}")
      message(DEBUG "Found QT_INSTALL_DOCS: ${QT_INSTALL_DOCS}")
    else()
      set(_reason "Failed to find QT_INSTALL_DOCS: ${_commandOutput} ${_commandError} [${_commandResult}]")
    endif()
  endif()
endif()

# Locate each of the requested (both required, and optional) components.
if (QT_INSTALL_DOCS)
  foreach(Component ${${CMAKE_FIND_PACKAGE_NAME}_FIND_COMPONENTS})
    if (NOT ${CMAKE_FIND_PACKAGE_NAME}_FIND_QUIETLY)
      message(DEBUG "Finding ${Component}")
    endif()
    string(TOLOWER "${Component}" component)
    unset(_missingFiles)
    foreach(ext index;qch;tags)
      message(DEBUG "Looking for qt${component}.${ext} in ${QT_INSTALL_DOCS}")
      string(TOUPPER "${ext}" EXT)
      set(_variableName "${CMAKE_FIND_PACKAGE_NAME}_${Component}_${EXT}")
      find_file("${_variableName}"
        NAMES "qt${component}.${ext}"
        PATHS "${QT_INSTALL_DOCS}"
        PATH_SUFFIXES "qt${component}"
        NO_DEFAULT_PATH)
      message(DEBUG "${_variableName}: ${${_variableName}}")
      if(NOT ${_variableName})
        message(DEBUG "Failed to find qt${component}.${ext} in ${QT_INSTALL_DOCS}")
        list(APPEND _missingFiles "qt${component}.${ext}")
        if (${CMAKE_FIND_PACKAGE_NAME}_FIND_REQUIRED_${Component} AND NOT DEFINED _reason)
          set(_reason "Failed to find qt${component}.${ext} in ${QT_INSTALL_DOCS}")
        endif()
      endif()
    endforeach()
    if(NOT _missingFiles)
      set("${CMAKE_FIND_PACKAGE_NAME}_${Component}_FOUND" TRUE)
    endif()
  endforeach()
endif()
message(DEBUG "Reason: ${_reason}")
list(POP_BACK CMAKE_MESSAGE_INDENT)

# Report our success/failure.
include(FindPackageHandleStandardArgs)
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.16") # REASON_FAILURE_MESSAGE added in CMake 3.16.
  find_package_handle_standard_args("${CMAKE_FIND_PACKAGE_NAME}"
    REQUIRED_VARS QT_INSTALL_DOCS
    HANDLE_COMPONENTS
    REASON_FAILURE_MESSAGE "${_reason}")
else()
  if(DEFINED _reason)
    message(NOTICE "${_reason}")
  endif()
  find_package_handle_standard_args("${CMAKE_FIND_PACKAGE_NAME}"
    REQUIRED_VARS QT_INSTALL_DOCS
    HANDLE_COMPONENTS)
endif()
