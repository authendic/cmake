cmake_minimum_required(VERSION 3.10)

#==== 自动从git加载cmake modules ===
if(NOT MODULE_DEBUG)
include(FetchContent)
fetchcontent_declare(git_cmake
    GIT_REPOSITORY https://github.com/authendic/cmake.git
    GIT_TAG main
    )

fetchcontent_makeavailable(git_cmake)
list(APPEND CMAKE_MODULE_PATH ${git_cmake_SOURCE_DIR})
else()
list(APPEND CMAKE_MODULE_PATH $ENV{HOME}/gits/src/github.com/authendic/cmake)
endif()
# ===========

include(UseClang)
# for show_var
include(Printing)

set(CMAKE_EXPORT_COMPILE_COMMANDS, 1)
project(helloworld VERSION 0.0.1.456)
check_clang_compile_flag()

message("======= show_var =======")
show_var(
    PROJECT_NAME
    PROJECT_SOURCE_DIR
    PROJECT_BINARY_DIR
    CMAKE_CXX_FLAGS
    CMAKE_C_FLAGS
    )

add_executable(helloworld src/helloworld.cpp)
