cmake_minimum_required(VERSION 3.7)
project(libco)

set(CMAKE_CXX_STANDARD 11)
enable_language(ASM)

set(COMMON_SOURCE_FILES
        co_closure.h
        co_epoll.cpp
        co_epoll.h
        co_hook_sys_call.cpp
        co_routine.cpp
        co_routine.h
        co_routine_inner.h
        co_routine_specific.h
        coctx.cpp
        coctx.h
        coctx_swap.S)

set(coroutine_source_file
        co_routine.cpp
        co_routine.h
        co_routine_inner.h
        co_routine_specific.h
        coctx.cpp
        coctx.h
        coctx_swap.S)

set(CMAKE_CXX_FLAGS_RELEASE "-O2 -g")

link_libraries(-pthread)

MESSAGE(STATUS "operation system is ${CMAKE_SYSTEM_PROCESSOR}")

#add_executable(echosvr ${COMMON_SOURCE_FILES} echosvr.cpp)
#add_executable(example_echosvr ${COMMON_SOURCE_FILES} example_echosvr.cpp)
add_executable(coroutine_test ${coroutine_source_file} test_coroutine.cpp)
add_executable(cond ${coroutine_source_file} example_cond.cpp)
