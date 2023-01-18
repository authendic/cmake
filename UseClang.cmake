cmake_minimum_required(VERSION 3.10)

if(NOT OVERRIDES_DIR)
    set(CLANG_OVERRIDES_DIR ${CMAKE_CURRENT_LIST_DIR}/flag_overrides)
else()
    set(CLANG_OVERRIDES_DIR ${OVERRIDES_DIR})
endif()

set(CMAKE_USER_MAKE_RULES_OVERRIDE
    ${CLANG_OVERRIDES_DIR}/c_flag_overrides.cmake)
set(CMAKE_USER_MAKE_RULES_OVERRIDE_CXX
    ${CLANG_OVERRIDES_DIR}/cxx_flag_overrides.cmake)


set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(_CMAKE_TOOLCHAIN_PREFIX llvm-)

include(FlagsManager)
include(CheckCXXCompilerFlag)
 
macro(check_clang_compile_flag)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
CHECK_CXX_COMPILER_FLAG("-std=c++17" COMPILER_SUPPORTS_CXX17)
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
CHECK_CXX_COMPILER_FLAG("-std=c++20" COMPILER_SUPPORTS_CXX20)

if(COMPILER_SUPPORTS_CXX20)
    flags_add(CMAKE_CXX_FLAGS -std=c++20)
elseif(COMPILER_SUPPORTS_CXX17)
    flags_add(CMAKE_CXX_FLAGS -std=c++17)
elseif(COMPILER_SUPPORTS_CXX11)
    flags_add(CMAKE_CXX_FLAGS -std=c++11)
elseif(COMPILER_SUPPORTS_CXX0X)
    flags_add(CMAKE_CXX_FLAGS -std=c++0x)
else()
    message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif()

flags_make_str(CMAKE_CXX_FLAGS)
endmacro()
