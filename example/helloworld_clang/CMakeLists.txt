cmake_minimum_required(VERSION 3.10)

include(FetchContent)
fetchcontent_declare(git_cmake
    GIT_REPOSITORY https://github.com/authendic/cmake.git
    GIT_TAG main
    )

fetchcontent_makeavailable(git_cmake)
list(APPEND CMAKE_MODULE_PATH ${git_cmake_SOURCE_DIR})

include(UseClang)
set(CMAKE_EXPORT_COMPILE_COMMANDS, 1)
project(helloworld VERSION 0.0.1.456)
check_clang_compile_flag()

add_executable(helloworld src/helloworld.cpp)
