# - Find PHP
# This module finds if php-dev is installed and determines where the include files
# and libraries are.  This code sets the following variables:
#
#  PHP_CONFIG_DIR        = directory containing PHP configuration files
#  PHP_CONFIG_EXECUTABLE = full path to the php-config binary
#  PHP_EXECUTABLE        = full path to the php5 binary
#  PHP_EXTENSION_DIR     = directory containing PHP extensions
#  PHP_INCLUDE_DIR       = directory containing PHP extension headers
#  PHP_INCLUDES          = include directives for PHP development
#  PHP_VERNUM            = PHP version number eg 50303
#  PHP_VERSION           = PHP version string eg 5.3.3-1ubuntu9.3
#  PHPDEV_FOUND          = set to TRUE if all of the above has been found.
#
# Written by Paul Colby (http://colby.id.au), no rights reserved.
#

FIND_PROGRAM(PHP_CONFIG_EXECUTABLE NAMES php-config5 php-config4 php-config)

if (PHP_CONFIG_EXECUTABLE)
  execute_process(
    COMMAND
      ${PHP_CONFIG_EXECUTABLE} --configure-options
    COMMAND sed -ne "s/^.*--with-config-file-scan-dir=\\([^ ]*\\).*/\\1/p"
      OUTPUT_VARIABLE PHP_CONFIG_DIR
      OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  execute_process(
    COMMAND
      ${PHP_CONFIG_EXECUTABLE} --php-binary
      OUTPUT_VARIABLE PHP_EXECUTABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  execute_process(
    COMMAND
      ${PHP_CONFIG_EXECUTABLE} --extension-dir
      OUTPUT_VARIABLE PHP_EXTENSION_DIR
      OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  execute_process(
    COMMAND
      ${PHP_CONFIG_EXECUTABLE} --include-dir
      OUTPUT_VARIABLE PHP_INCLUDE_DIR
      OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  execute_process(
    COMMAND
      ${PHP_CONFIG_EXECUTABLE} --includes
      OUTPUT_VARIABLE PHP_INCLUDES
      OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  execute_process(
    COMMAND
      ${PHP_CONFIG_EXECUTABLE} --vernum
      OUTPUT_VARIABLE PHP_VERNUM
      OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  execute_process(
    COMMAND
      ${PHP_CONFIG_EXECUTABLE} --version
      OUTPUT_VARIABLE PHP_VERSION
      OUTPUT_STRIP_TRAILING_WHITESPACE
  )
endif (PHP_CONFIG_EXECUTABLE)

MARK_AS_ADVANCED(
  PHP_CONFIG_DIR
  PHP_CONFIG_EXECUTABLE
  PHP_EXECUTABLE
  PHP_EXTENSION_DIR
  PHP_INCLUDE_DIR
  PHP_INCLUDES
  PHP_VERNUM
  PHP_VERSION
)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(
  phpdev
  DEFAULT_MSG
  PHP_VERSION
  PHP_CONFIG_DIR
  PHP_CONFIG_EXECUTABLE
  PHP_EXECUTABLE
  PHP_EXTENSION_DIR
  PHP_INCLUDE_DIR
  PHP_INCLUDES
  PHP_VERNUM
)

#MESSAGE("PHP_CONFIG_DIR        = ${PHP_CONFIG_DIR}")
#MESSAGE("PHP_CONFIG_EXECUTABLE = ${PHP_CONFIG_EXECUTABLE}")
#MESSAGE("PHP_EXECUTABLE        = ${PHP_EXECUTABLE}")
#MESSAGE("PHP_EXTENSION_DIR     = ${PHP_EXTENSION_DIR}")
#MESSAGE("PHP_INCLUDE_DIR       = ${PHP_INCLUDE_DIR}")
#MESSAGE("PHP_INCLUDES          = ${PHP_INCLUDES}")
#MESSAGE("PHP_VERNUM            = ${PHP_VERNUM}")
#MESSAGE("PHP_VERSION           = ${PHP_VERSION}")
#MESSAGE("PHPDEV_FOUND          = ${PHPDEV_FOUND}")
