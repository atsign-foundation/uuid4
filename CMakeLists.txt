cmake_minimum_required(VERSION 3.24)

set(UUID4_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/uuid4.c
)

set(UUID4_INCLUDE_DIR
    ${CMAKE_CURRENT_LIST_DIR}/include
)

if(ESP_PLATFORM)
    # Run special CMake commands for ESP32
    idf_component_register(
        SRCS ${UUID4_SOURCES}
        INCLUDE_DIRS ${UUID4_INCLUDE_DIR}
        REQUIRES 
    )

    # Copy header files to include directory and libraries to lib directory
    add_custom_command(
        TARGET ${COMPONENT_LIB}
        POST_BUILD
        COMMAND
        ${CMAKE_COMMAND} -E copy_directory ${UUID4_INCLUDE_DIR}
        ${CMAKE_SOURCE_DIR}/include
        COMMAND
        ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${COMPONENT_LIB}>
        ${CMAKE_SOURCE_DIR}/lib/lib${COMPONENT_NAME}.a
        COMMENT "Copying built archive file and header to lib directory..."
    )
endif()

project(
    uuid4
    VERSION 1.0.3
    LANGUAGES C
)

if(NOT ESP_PLATFORM)
    include(GNUInstallDirs)

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

    # ==============

    # ==============
    if(NOT DEFINED UUID4_AS_SUBPROJECT)
        set(UUID4_AS_SUBPROJECT ON)

        if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
            set(UUID4_AS_SUBPROJECT OFF)
        endif()
    endif()

    if(NOT UUID4_AS_SUBPROJECT)
        export(
            PACKAGE uuid4
        )

        # installs the cmake config file (/usr/local/lib/cmake/uuid4/uuid4-config.cmake), which is used by find_package
        install(
            EXPORT uuid4-config
            NAMESPACE uuid4::
            DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/uuid4
            FILE uuid4-config.cmake
        )

        export(
            EXPORT uuid4-config
            NAMESPACE uuid4::
            FILE uuid4-config.cmake
        )
    endif()

    add_library(uuid4::uuid4-static ALIAS uuid4-static)
    add_library(uuid4::uuid4-shared ALIAS uuid4-shared)

    # ==============
endif()