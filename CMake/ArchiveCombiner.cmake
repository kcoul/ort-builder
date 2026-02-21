# Implementation function for combine_archives on Linux
function(_combine_archives_linux output_archive)
    get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
    # Generate the MRI file for ar to consume.
    if(isMultiConfig)
        message("Multiconfig")
        # A separate file must be generated for each build configuration.
        set(mri_file ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/${output_archive}.mri)
        set(mri_file_content "create ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/lib${output_archive}.a\n")
    else()
        message("Single config")
        set(mri_file ${CMAKE_CURRENT_BINARY_DIR}/${output_archive}.mri)
        set(mri_file_content "create ${CMAKE_CURRENT_BINARY_DIR}/lib${output_archive}.a\n")
    endif()
    foreach(in_target ${ARGN})
        string(APPEND mri_file_content "addlib $<TARGET_FILE:${in_target}>\n")
    endforeach()
    string(APPEND mri_file_content "save\n")
    string(APPEND mri_file_content "end\n")
    file(GENERATE
            OUTPUT ${mri_file}
            CONTENT ${mri_file_content}
            )

    # Create a dummy file for the combined library
    # This dummy file depends on all the input targets so that the combined library is regenerated if any of them changes.
    set(output_archive_dummy_file ${CMAKE_CURRENT_BINARY_DIR}/${output_archive}.dummy.cpp)
    add_custom_command(OUTPUT ${output_archive_dummy_file}
            COMMAND ${CMAKE_COMMAND} -E touch ${output_archive_dummy_file}
            DEPENDS ${ARGN})

    add_library(${output_archive} STATIC ${output_archive_dummy_file})

    # Add a custom command to combine the archives after the static library is "built".
    add_custom_command(TARGET ${output_archive}
            POST_BUILD
            COMMAND ar -M < ${mri_file}
            COMMENT "Combining static libraries for ${output_archive}"
            )
endfunction()

# Implementation function for combine_archives on Windows
function(_combine_archives_windows output_archive)
    get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
    if(isMultiConfig)
        # A separate file must be generated for each build configuration.
        set(output_archive_path ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/${output_archive}.lib)
    else()
        set(output_archive_path ${CMAKE_CURRENT_BINARY_DIR}/${output_archive}.lib)
    endif()
    foreach(in_target ${ARGN})
        list(APPEND input_archive_files "$<TARGET_FILE:${in_target}> ")
    endforeach()

    # Create a dummy file for the combined library
    # This dummy file depends on all the input targets so that the combined library is regenerated if any of them changes.
    set(output_archive_dummy_file ${CMAKE_CURRENT_BINARY_DIR}/${output_archive}.dummy.cpp)
    add_custom_command(OUTPUT ${output_archive_dummy_file}
            COMMAND ${CMAKE_COMMAND} -E touch ${output_archive_dummy_file}
            DEPENDS ${ARGN})

    add_library(${output_archive} STATIC ${output_archive_dummy_file})

    # Add a custom command to combine the archives after the static library is "built".
    add_custom_command(TARGET ${output_archive}
            POST_BUILD
            COMMAND lib.exe /OUT:${output_archive_path} ${input_archive_files}
            COMMENT "Combining static libraries for ${output_archive}"
            )
endfunction()

# Implementation function for combine_archives on Apple platforms
function(_combine_archives_apple output_archive)
    foreach(in_target ${ARGN})
        list(APPEND input_archive_files "$<TARGET_FILE:${in_target}>")
    endforeach()

    # Create a dummy file for the combined library
    # This dummy file depends on all the input targets so that the combined library is regenerated if any of them changes.
    set(output_archive_dummy_file ${CMAKE_CURRENT_BINARY_DIR}/${output_archive}.dummy.cpp)
    add_custom_command(OUTPUT ${output_archive_dummy_file}
            COMMAND ${CMAKE_COMMAND} -E touch ${output_archive_dummy_file}
            DEPENDS ${ARGN})

    add_library(${output_archive} STATIC ${output_archive_dummy_file})

    # Add a custom command to combine the archives after the static library is "built".
    add_custom_command(TARGET ${output_archive}
            POST_BUILD
            COMMAND libtool -static -no_warning_for_no_symbols -o $<TARGET_FILE:${output_archive}> ${input_archive_files}
            COMMENT "Combining static libraries for ${output_archive}"
            )
endfunction()

# Combine a list of library targets into a single output archive
# Usage:
# combine_archives(output_archive_name input_target1 input_target2...)
function(combine_archives output_archive)
    if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
        _combine_archives_linux(${output_archive} ${ARGN})
    elseif(CMAKE_SYSTEM_NAME STREQUAL "Android" AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
        _combine_archives_linux(${output_archive} ${ARGN})
    elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
        _combine_archives_windows(${output_archive} ${ARGN})
    elseif(CMAKE_SYSTEM_NAME MATCHES "^(Darwin|iOS)")
        _combine_archives_apple(${output_archive} ${ARGN})
    else()
        message(FATAL "combine_archives is not implemented for system: ${CMAKE_SYSTEM_NAME}")
    endif()
endfunction(combine_archives)

