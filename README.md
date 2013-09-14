cmake-modules
=============

This is just my own collection of modules for [cmake](http://www.cmake.org/)

## Modules

### [FindPHP](FindPHP.cmake)
This module determines if PHP is installed, and if so the location of the PHP include files and libraries.

Unlike the `FindPHP4` module included with cmake, this module uses the
[`php-config`](http://php.net/manual/en/install.pecl.php-config.php) script to determine
information about the installed PHP configuration.  Among other things, this means that this
module is compatible with both PHP 4 and 5.

For Linux distributions, this [`php-config`](http://php.net/manual/en/install.pecl.php-config.php)
script is normally installed as part of some `php-dev` or `php-devel` package.
