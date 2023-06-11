#[=[
usage:

```
include(UseClang) # 该行必须在project()之前
project(helloworld VERSION 0.0.1.456)
check_clang_compile_flag() # 该行必须在project()之后

```

该脚本用于为Clang准备好工具链配置。 

]=]
cmake_minimum_required(VERSION 3.10)

if(NOT OVERRIDES_DIR)
    set(CLANG_OVERRIDES_DIR ${CMAKE_CURRENT_LIST_DIR}/flag_overrides)
else()
    set(CLANG_OVERRIDES_DIR ${OVERRIDES_DIR})
endif()

# CMAKE 重载用户自定义的规则
set(CMAKE_USER_MAKE_RULES_OVERRIDE
    ${CLANG_OVERRIDES_DIR}/c_flag_overrides.cmake)
set(CMAKE_USER_MAKE_RULES_OVERRIDE_CXX
    ${CLANG_OVERRIDES_DIR}/cxx_flag_overrides.cmake)


set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
# 指定 toolchain 前缀，使用llvm 工具链
set(_CMAKE_TOOLCHAIN_PREFIX llvm-)

# 引入本项目插件 FlagsManager
# flags_add(My_Flags --std=c++20 -g -I. -ggdb) 
# flags_make_str(My_Flags)
# 向变量 My_Flags 添加flags, 最终编译成一个字符串
include(FlagsManager)
# 引入builtin 插件
include(CheckCXXCompilerFlag)

include(Printing)
 
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
