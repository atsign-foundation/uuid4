
cmake_minimum_required(VERSION 3.19)

project(
    uuid4
    VERSION 1.0.1
    LANGUAGES C
)

include(GNUInstallDirs)

set(UUID4_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/uuid4.c
)

set(UUID4_HEADERS ${CMAKE_CURRENT_LIST_DIR}/include)

add_library(uuid4-static STATIC ${UUID4_SOURCES})
add_library(uuid4-shared SHARED ${UUID4_SOURCES})

target_include_directories(uuid4-static PUBLIC
    $<BUILD_INTERFACE:${UUID4_HEADERS}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
target_include_directories(uuid4-shared PUBLIC
    $<BUILD_INTERFACE:${UUID4_HEADERS}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

# ==============
# configures the install function

# installs the lib targets (.a and .dylib to /usr/local/lib)
install(
    TARGETS uuid4-static uuid4-shared
    EXPORT uuid4-config
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

# installs the headers (/usr/local/include/uuid4)
install(
    DIRECTORY ${UUID4_HEADERS}/${RPOJECT_NAME}
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# installs the cmake config file (/usr/local/lib/cmake/uuid4/uuid4-config.cmake), which is used by find_package
install(
    EXPORT uuid4-config
    NAMESPACE uuid4::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/uuid4
    FILE uuid4-config.cmake
)
# ==============

# ==============
# in case we are used as a subproject
# or FetchContent

export(
    EXPORT uuid4-config
    NAMESPACE uuid4::
    FILE ${CMAKE_CURRENT_BINARY_DIR}/uuid4-config.cmake
)

export(
    PACKAGE uuid4
)

add_library(uuid4::uuid4-static ALIAS uuid4-static)
add_library(uuid4::uuid4-shared ALIAS uuid4-shared)
# ==============