## FindQtDoc

Find installed Qt documentation.

### Prerequisites

This module depends on variables set by the official FindQt modules. So will need invoke something like this first:

```cmake
find_package(QT ... NAMES Qt6 Qt5)
find_package(Qt${QT_VERSION_MAJOR} ...)
```

### Installation

You can either copy this file to a sensible folder in your project, for example `./cmake`, and add the folder to
`CMAKE_CURRENT_SOURCE_DIR` like:

```cmake
list(PREPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
```

Or use CMake to fetch the the module from GitHub like:

```cmake
include(FetchContent)
FetchContent_Declare(
  FindQtDocs
  GIT_REPOSITORY "https://github.com/pcolby/cmake-modules"
  GIT_TAG        "123f3b54b5049757830569ccb89ada8d6ecff41b"
)
FetchContent_MakeAvailable(FindQtDocs)
list(PREPEND CMAKE_MODULE_PATH "${findqtdocs_SOURCE_DIR}")
```

### Usage

Once installed, use CMake's `find_package()` function, optionally passing require and optional Qt components.

```cmake
find_package(QtDocs [REQUIRED] [COMPONENTS <qt-components>] [OPTIONAL_COMPONENTS <more-qt-components>])
```

If successful, the following variables will be set:

|     Variable      |               Descripton                |        Example       |
|-------------------|-----------------------------------------|----------------------|
| `QtDocs_FOUND`    | indicates whether the package was found | `TRUE`               |
| `QT_INSTALL_DOCS` | root path of installed Qt docs          | `/usr/share/qt5/doc` |

And for each requested CMake component (Qt module):

|        Variable         |                     Descripton                   |        Example       |
|-------------------------|--------------------------------------------------|----------------------|
| `QtDocs_<Component>_FOUND` | indicates whether the doc was found  | `TRUE`
| `QtDocs_<Component>_INDEX` | path to the documentation's XML index  | `/usr/share/qt5/doc/qtcore/qtcore.index` |
| `QtDocs_<Component>_QCH`   | path to the documentation's QCH file   | `/usr/share/qt5/doc/qtcore/qtcore.qch`   |
| `QtDocs_<Component>_TAGS`  | path to the documentation's TAGS file  | `/usr/share/qt5/doc/qtcore/qtcore.tags`  |

### Example

An example, finding the documentation for Qt's Core and Bluetooth modules:

```cmake
# Find Qt
find_package(QT REQUIRED COMPONENTS Core Bluetooth NAMES Qt6 Qt5)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Bluetooth)

# Find Qt docs
include(FetchContent)
FetchContent_Declare(
  FindQtDocs
  GIT_REPOSITORY "https://github.com/pcolby/cmake-modules"
  GIT_TAG        "fe64e68378f04cd6bd13e1c1f548bac58e316311"
)
FetchContent_MakeAvailable(FindQtDocs)
list(PREPEND CMAKE_MODULE_PATH "${findqtdocs_SOURCE_DIR}")
find_package(QtDocs REQUIRED COMPONENTS Core Bluetooth)

# Include Qt doc tagfiles, if available.
if (QtDocs_FOUND)
  set(QT_DOCS_BASEURL "https://doc.qt.io/qt-${QT_VERSION_MAJOR}/")
  message(STATUS "Using Qt doc tagfiles ${QT_INSTALL_DOCS} => ${QT_DOCS_BASEURL}")
  set(DOX_TAGFILES "\\
  \"${QtDocs_Core_TAGS}=${QT_DOCS_BASEURL}\" \\
  \"${QtDocs_Bluetooth_TAGS}=${QT_DOCS_BASEURL}\" \\")
endif()
```
