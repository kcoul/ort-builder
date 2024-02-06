#!/usr/bin/env bash
set -euf -o pipefail

#ONNX_CONFIG="${1:-model.required_operators_and_types.config}"
CMAKE_BUILD_TYPE=MinSizeRel
ARCH=arm64

python3 onnxruntime/tools/ci_build/build.py \
--build_dir "onnxruntime/build/iOS-${ARCH}" \
--config=${CMAKE_BUILD_TYPE} \
--ios \
--use_xcode \
--build_apple_framework \
--apple_sysroot iphoneos \
--osx_arch ${ARCH} \
--parallel \
--minimal_build \
--apple_deploy_target="14.0" \
--disable_ml_ops --disable_rtti \
--cmake_extra_defines CMAKE_OSX_ARCHITECTURES="${ARCH}" \
--skip_tests

DEPENDENCY_BUILD_DIR=./onnxruntime/build/iOS-${ARCH}/${CMAKE_BUILD_TYPE}/static_libraries
ONNX_BUILD_DIR=./onnxruntime/build/iOS-${ARCH}/${CMAKE_BUILD_TYPE}/MinSizeRel-iphoneos

libtool -static -o "./libs/ios-arm64/libonnxruntime.a" \
"${ONNX_BUILD_DIR}/libonnxruntime_graph.a" \
"${ONNX_BUILD_DIR}/libonnxruntime_mlas.a" \
"${ONNX_BUILD_DIR}/libonnxruntime_optimizer.a" \
"${ONNX_BUILD_DIR}/libonnxruntime_providers.a" \
"${ONNX_BUILD_DIR}/libonnxruntime_common.a" \
"${ONNX_BUILD_DIR}/libonnxruntime_session.a" \
"${ONNX_BUILD_DIR}/libonnxruntime_flatbuffers.a" \
"${ONNX_BUILD_DIR}/libonnxruntime_framework.a" \
"${ONNX_BUILD_DIR}/libonnxruntime_util.a" \
"${DEPENDENCY_BUILD_DIR}/libonnx.a" \
"${DEPENDENCY_BUILD_DIR}/libonnx_proto.a" \
"${DEPENDENCY_BUILD_DIR}/libre2.a" \
"${DEPENDENCY_BUILD_DIR}/libnsync_cpp.a" \
"${DEPENDENCY_BUILD_DIR}/libprotobuf-lite.a" \
"${DEPENDENCY_BUILD_DIR}/libabsl_hash.a" \
"${DEPENDENCY_BUILD_DIR}/libabsl_city.a" \
"${DEPENDENCY_BUILD_DIR}/libabsl_low_level_hash.a" \
"${DEPENDENCY_BUILD_DIR}/libabsl_throw_delegate.a" \
"${DEPENDENCY_BUILD_DIR}/libabsl_raw_hash_set.a" \
"${DEPENDENCY_BUILD_DIR}/libabsl_raw_logging_internal.a"