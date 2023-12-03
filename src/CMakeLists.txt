add_executable(${PROJECT_EXECUTABLE} "./main.cpp" "./main.h")
target_include_directories(${PROJECT_EXECUTABLE} PRIVATE  ${CMAKE_BINARY_DIR}/configured/include)

# [ Enable Warnings ]
if(${ENABLE_WARNINGS})
    ADD_WARNINGS_TO_TARGET(
        TARGET
        ${PROJECT_EXECUTABLE}
        ENABLE
        ${ENABLE_WARNINGS}
        AS_ERRORS
        ${ENABLE_WARNINGS_AS_ERRORS}
    )
endif()

# [ Enable Clang Tidy ]
if(ENABLE_CLANG_TIDY)
    ADD_CLANG_TIDY_TO_TARGET(${PROJECT_EXECUTABLE})
endif()

# [ Enable Clang Tidy ]
if(${ENABLE_LTO})
    ADD_LTO_TO_TARGET(
        TARGET
        ${PROJECT_EXECUTABLE}
        ENABLE
        ON
    )
endif()

# [ Enable Graphviz ]
if(GEN_GRAPHVIZ_PNG)
    find_program(GRAPHVIZ dot)

    if(GRAPHVIZ)
        add_custom_target(graphviz ALL
            COMMAND ${CMAKE_COMMAND} "--graphviz=dep-graph/foo.dot" .
            COMMAND dot -Tpng dep-graph/foo.dot -o dep-graph/foo.png
            WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
        )

        add_dependencies(${PROJECT_EXECUTABLE} graphviz)
    else()
        set(ERROR "Graphviz is required to access this target.")
    endif()
endif()
