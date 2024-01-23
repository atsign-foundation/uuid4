
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

install(
    TARGETS uuid4-static uuid4-shared
    EXPORT uuid4-config
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(
    EXPORT uuid4-config
    NAMESPACE uuid4::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/uuid4
    FILE uuid4-config.cmake
)

install(
    DIRECTORY ${UUID4_HEADERS}/${RPOJECT_NAME}
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)