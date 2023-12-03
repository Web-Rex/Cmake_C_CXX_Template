configure_file(
    "${CMAKE_SOURCE_DIR}/cmake/cpp.in/config.hpp.in"
    "${CMAKE_BINARY_DIR}/configured/include/config.h" ESCAPE_QUOTES
)
