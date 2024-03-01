#!/bin/bash
python3 onnxruntime/tools/ci_build/build.py \
--build_dir onnxruntime/build/wasm \
--config=MinSizeRel \
--build_wasm_static_lib \
--parallel \
--minimal_build \
--disable_ml_ops --disable_exceptions --disable_rtti \
--skip_tests
