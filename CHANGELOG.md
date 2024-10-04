# UUID4 CHANGELOG

## 1.0.4

- Added workflow to build tarball with attestations
- Fixed example build script after relocation of uuid4.h

## 1.0.3

- CMakeLists.txt now has Espressif support to be added as a component in your
ESP-IDF projects.
- Added ESP32 support in uuid.c
- Added idf_component.yml manifest to soon be uploaded to the Espressif
component registry.

## 1.0.2

- Established this CHANGELOG
- LICENSE updated to reflect fork
- README linting and note on fork
- Copy boilerplate from archetype

## 1.0.1

- Support for OpenBSD and NetBSD
- Thread Safety for C11+ Compilers
- Refactored uuid4.h to include/uuid/ directory
- CMake subdirectory AND installation compatability

## 1.0.0

- Initial fork from [rxi/uuid4](https://github.com/rxi/uuid4)
