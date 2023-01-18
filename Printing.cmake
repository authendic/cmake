#[=======================================================================[.markdown:

```cmake
include(Printing)
show_var(
   PROJECT_NAME
   PROJECT_SOURCE_DIR
)
```

]=======================================================================]

function(show_var)
    foreach(var IN LISTS ARGN)
        message(${var} " = " ${${var}})
    endforeach()
endfunction()

function(PrintingLoaded)
    message(STATUS "Printing.cmake in ${CMAKE_CURRENT_FUNCTION_LIST_DIR} is loaded")
endfunction()

PrintingLoaded()
