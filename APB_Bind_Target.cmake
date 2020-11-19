function(apb_add_module target)
    get_target_property(target_name ${target} NAME)
    string(REPLACE "::" "" target_py_name ${target_name})
    if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/wrappers/${target_py_name}_input.yml)
        file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${target_py_name})
        autopybind11_add_module(${target_py_name}
                                YAML_INPUT ${CMAKE_CURRENT_SOURCE_DIR}/wrappers/${target_py_name}_input.yml
                                CONFIG_INPUT ${CMAKE_CURRENT_SOURCE_DIR}/configs/${target_py_name}_config.yml
                                DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
                                LINK_LIBRARIES ${target}
                            )
    endif()
endfunction(apb_add_module)
