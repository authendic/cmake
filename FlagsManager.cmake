#[=[.markdown
usage:

```
flags_add(Clang_Flags --std=c++20 -g -I. -ggdb)
flags_add(Clang_Flags -O0)
flags_add(Clang_Flags -g)
flags_add(Clang_Flags -O0)
flags_make_str(Clang_Flags)
message(${Clang_Flags})
```

will produce string: "--std=c++20 -g -I. -ggdb -O0"

]=]

cmake_minimum_required(VERSION 3.10)

function(flags_add name)
    set(${name}_list ${${name}_list} ${ARGN} PARENT_SCOPE)
endfunction()

function(flags_make_str name)
    string (REPLACE " " ";" tmpFLAGS_list "${${name}}")
    flags_add(tmpFLAGS ${${name}_list})
    list(REMOVE_DUPLICATES tmpFLAGS_list)
    string (REPLACE ";" " " FLAGS_STR "${tmpFLAGS_list}")
    set(${name} ${FLAGS_STR} PARENT_SCOPE)
endfunction()

include(Printing)
