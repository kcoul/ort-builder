#!/bin/bash

arch="$1" #choose from 'armeabi-v7a', 'arm64-v8a', 'x86', 'x86_64'

python3 onnxruntime/tools/ci_build/build.py \
--build_dir "onnxruntime/build/android_${arch}" \
--config=MinSizeRel \
--android \
--android_abi="${arch}" \
--parallel \
--minimal_build \
--disable_ml_ops --disable_exceptions --disable_rtti \
--skip_tests
