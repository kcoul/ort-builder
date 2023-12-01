#!/bin/bash

arch="$1"

python3 onnxruntime/tools/ci_build/build.py \
--build_dir "onnxruntime/build/android_${arch}" \
--config=MinSizeRel \
--android \
--android_abi="${arch}" \
--parallel \
--minimal_build \
--disable_ml_ops --disable_exceptions --disable_rtti \
--include_ops_by_config model.required_operators_and_types.config \
--enable_reduced_operator_type_support \
--skip_tests

mkdir -p "libs/android_${arch}"

#TODO: 
## Create a .mri file for combining archives using ar tool (Linux/Android)
## Set output target name for .mri to match desired combined archive name

## "libs/android_${arch}/onnxruntime.a" \

## Add boiler-plate contents to .mri and add all relevant archives

#"./onnxruntime/build/android_${arch}/MinSizeRel/libonnx.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_graph.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/libonnx_proto.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_mlas.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_optimizer.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_providers.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_common.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_session.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_flatbuffers.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_framework.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/libonnxruntime_util.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/_deps/re2-build/libre2.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/_deps/google_nsync-build/libnsync_cpp.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/_deps/protobuf-build/libprotobuf-lite.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_hash.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_city.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_low_level_hash.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/_deps/abseil_cpp-build/absl/base/libabsl_throw_delegate.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/_deps/abseil_cpp-build/absl/container/libabsl_raw_hash_set.a" \
#"./onnxruntime/build/android_${arch}/MinSizeRel/_deps/abseil_cpp-build/absl/base/libabsl_raw_logging_internal.a" 

## Call ar on .mri file

# ar -M libs/android_${arch}.mri
