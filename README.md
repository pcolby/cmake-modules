cmake-modules
=============

This is just my own collection of modules for [cmake](http://www.cmake.org/)

## Modules

### [FindPHP](FindPHP.cmake)
This module determines if PHP is installed, and if so the location of the PHP include files and libraries.

Unlike the `FindPHP4` module included with cmake, this module uses the
[`php-config`](http://php.net/manual/en/install.pecl.php-config.php) script to determine
information about the installed PHP configuration.  Among other things, this means that this
module is compatible with both PHP4 and PHP5.

The module is self-documented, so just read the documentation at the top of the [FindPHP.cmake](FindPHP.cmake)
file itself.

Tip: On Linux distributions, the [`php-config`](http://php.net/manual/en/install.pecl.php-config.php)
script is normally installed as part of a `php-dev` or `php-devel` package.
