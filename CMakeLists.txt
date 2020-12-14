CMAKE_MINIMUM_REQUIRED(VERSION 3.18)
project(APB-VTK)
# Grab python3 version greater than 3.4 for pybind11 combaitibilty
#
find_package(Python3 3.5 REQUIRED COMPONENTS Interpreter Development)

# Import APB
#
include(FetchContent)
FetchContent_Declare(
    autopybind11
    GIT_REPOSITORY https://gitlab.kitware.com/autopybind11/autopybind11.git
    GIT_TAG ddda03ffe8294fcca1656adefe5c690ebf88f7b6
    )

# Import APB into current CMake context
#
FetchContent_MakeAvailable(autopybind11)
find_package(AutoPyBind11)

# install APB
message(STATUS "Install APB")
execute_process(COMMAND ${Python3_EXECUTABLE} -m pip install
    ${autopybind11_SOURCE_DIR})

# fetch, "build", and import pybind11 into current scope for APB.
# pybind11 is hearder only, so no real build step
autopybind11_fetch_build_pybind11()

# now we import VTK common targets for binding and linking with APB

set(VTK_BUILD_TREE "" CACHE PATH "Location of VTK build tree")
message(STATUS ${VTK_BUILD_TREE})

find_package(VTK REQUIRED PATHS ${VTK_BUILD_TREE})
message(STATUS "VTKFound ... Importing VTKCommon Targets ...")

set(VTKCommonTargets_)

foreach(target ${VTK_LIBRARIES})
    get_target_property(target_name ${target} NAME)
    string(FIND ${target_name} "Common" is_common)
    if(NOT is_common EQUAL -1)
        message(STATUS "${target} Found, will be bound by APB")
        list(APPEND VTKCommonTargets_ ${target})
    endif()
endforeach()

# Setup APB for each VTK Common Component
# We will produce an APB generated module per VTKCommon Component


include(APB_Bind_Target.cmake)
foreach(target ${VTKCommonTargets_})
    apb_add_module(${target})
endforeach()
