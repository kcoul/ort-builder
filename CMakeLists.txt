cmake_minimum_required(VERSION 3.19)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/CMake)

project(OrtBuilder)

#TODO: Call build script for detected platform

#Now the archives are combined using ArchiveCombiner.cmake

## "libs/android_${arch}/onnxruntime.a" \

## Add boiler-plate contents to .mri and add all relevant archives

include(ArchiveCombiner)

add_library(onnx STATIC IMPORTED) #1
add_library(onnxruntime_graph STATIC IMPORTED) #2
add_library(onnx_proto STATIC IMPORTED) #3
add_library(onnxruntime_mlas STATIC IMPORTED) #4
add_library(onnxruntime_optimizer STATIC IMPORTED) #5
add_library(onnxruntime_providers STATIC IMPORTED) #6
add_library(onnxruntime_common STATIC IMPORTED) #7
add_library(onnxruntime_session STATIC IMPORTED) #8
add_library(onnxruntime_flatbuffers STATIC IMPORTED) #9
add_library(onnxruntime_framework STATIC IMPORTED) #10
add_library(onnxruntime_util STATIC IMPORTED) #11
add_library(re2 STATIC IMPORTED) #12
add_library(nsync_cpp STATIC IMPORTED) #13
add_library(protobuf-lite STATIC IMPORTED) #14
add_library(absl_hash STATIC IMPORTED) #15
add_library(absl_city STATIC IMPORTED) #16
add_library(absl_low_level_hash STATIC IMPORTED) #17
add_library(absl_throw_delegate STATIC IMPORTED) #18
add_library(absl_raw_hash_set STATIC IMPORTED) #19
add_library(absl_raw_logging_internal STATIC IMPORTED) #20
add_library(cpuinfo STATIC IMPORTED) #21

set(CMAKE_SYSTEM_NAME "Android")

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set_property(TARGET onnx PROPERTY #1
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/libonnx.a")
    set_property(TARGET onnxruntime_graph PROPERTY #2
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/libonnxruntime_graph.a")
    set_property(TARGET onnx_proto PROPERTY #3
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/libonnx_proto.a")
    set_property(TARGET onnxruntime_mlas PROPERTY #4
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/libonnxruntime_mlas.a")
    set_property(TARGET onnxruntime_optimizer PROPERTY #5
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/libonnxruntime_optimizer.a")
    set_property(TARGET onnxruntime_providers PROPERTY #6
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/libonnxruntime_providers.a")
    set_property(TARGET onnxruntime_common PROPERTY #7
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/libonnxruntime_common.a")
    set_property(TARGET onnxruntime_session PROPERTY #8
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/libonnxruntime_session.a")
    set_property(TARGET onnxruntime_flatbuffers PROPERTY #9
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/libonnxruntime_flatbuffers.a")
    set_property(TARGET onnxruntime_framework PROPERTY #10
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/libonnxruntime_framework.a")
    set_property(TARGET onnxruntime_util PROPERTY #11
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/libonnxruntime_util.a")
    set_property(TARGET re2 PROPERTY #12
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/_deps/re2-build/libre2.a")
    set_property(TARGET nsync_cpp PROPERTY #13
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/_deps/google_nsync-build/libnsync_cpp.a")
    set_property(TARGET protobuf-lite PROPERTY #14
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/_deps/protobuf-build/libprotobuf-lite.a")
    set_property(TARGET absl_hash PROPERTY #15
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_hash.a")
    set_property(TARGET absl_city PROPERTY #16
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_city.a")
    set_property(TARGET absl_low_level_hash PROPERTY #17
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_low_level_hash.a")
    set_property(TARGET absl_throw_delegate PROPERTY #18
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/_deps/abseil_cpp-build/absl/base/libabsl_throw_delegate.a")
    set_property(TARGET absl_raw_hash_set PROPERTY #19
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/_deps/abseil_cpp-build/absl/container/libabsl_raw_hash_set.a")
    set_property(TARGET absl_raw_logging_internal PROPERTY #20
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/_deps/abseil_cpp-build/absl/base/libabsl_raw_logging_internal.a")
    set_property(TARGET cpuinfo PROPERTY #21
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/Linux/MinSizeRel/_deps/pytorch_cpuinfo-build//libcpuinfo.a")

    combine_archives(onnxruntime
            onnx
            onnxruntime_graph
            onnx_proto
            onnxruntime_mlas
            onnxruntime_optimizer
            onnxruntime_providers
            onnxruntime_common
            onnxruntime_session
            onnxruntime_flatbuffers
            onnxruntime_framework
            onnxruntime_util
            re2
            nsync_cpp
            protobuf-lite
            absl_hash
            absl_city
            absl_low_level_hash
            absl_throw_delegate
            absl_raw_hash_set
            absl_raw_logging_internal
            cpuinfo)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Android" AND CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
    message("Combining archives for Android")
    set (arch "arm64-v8a")

    set_property(TARGET onnx PROPERTY #1
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/libonnx.a")
    set_property(TARGET onnxruntime_graph PROPERTY #2
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_graph.a")
    set_property(TARGET onnx_proto PROPERTY #3
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/libonnx_proto.a")
    set_property(TARGET onnxruntime_mlas PROPERTY #4
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_mlas.a")
    set_property(TARGET onnxruntime_optimizer PROPERTY #5
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_optimizer.a")
    set_property(TARGET onnxruntime_providers PROPERTY #6
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_providers.a")
    set_property(TARGET onnxruntime_common PROPERTY #7
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_common.a")
    set_property(TARGET onnxruntime_session PROPERTY #8
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_session.a")
    set_property(TARGET onnxruntime_flatbuffers PROPERTY #9
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_flatbuffers.a")
    set_property(TARGET onnxruntime_framework PROPERTY #10
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_framework.a")
    set_property(TARGET onnxruntime_util PROPERTY #11
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_util.a")
    set_property(TARGET re2 PROPERTY #12
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/_deps/re2-build/libre2.a")
    set_property(TARGET nsync_cpp PROPERTY #13
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/_deps/google_nsync-build/libnsync_cpp.a")
    set_property(TARGET protobuf-lite PROPERTY #14
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/_deps/protobuf-build/libprotobuf-lite.a")
    set_property(TARGET absl_hash PROPERTY #15
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_hash.a")
    set_property(TARGET absl_city PROPERTY #16
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_city.a")
    set_property(TARGET absl_low_level_hash PROPERTY #17
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_low_level_hash.a")
    set_property(TARGET absl_throw_delegate PROPERTY #18
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/_deps/abseil_cpp-build/absl/base/libabsl_throw_delegate.a")
    set_property(TARGET absl_raw_hash_set PROPERTY #19
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/_deps/abseil_cpp-build/absl/container/libabsl_raw_hash_set.a")
    set_property(TARGET absl_raw_logging_internal PROPERTY #20
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/_deps/abseil_cpp-build/absl/base/libabsl_raw_logging_internal.a")
    set_property(TARGET cpuinfo PROPERTY #21
            IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/onnxruntime/build/android_${arch}/MinSizeRel/_deps/pytorch_cpuinfo-build/libcpuinfo.a")
    combine_archives(onnxruntime
            onnx
            onnxruntime_graph
            onnx_proto
            onnxruntime_mlas
            onnxruntime_optimizer
            onnxruntime_providers
            onnxruntime_common
            onnxruntime_session
            onnxruntime_flatbuffers
            onnxruntime_framework
            onnxruntime_util
            re2
            nsync_cpp
            protobuf-lite
            absl_hash
            absl_city
            absl_low_level_hash
            absl_throw_delegate
            absl_raw_hash_set
            absl_raw_logging_internal
            cpuinfo)
endif()



