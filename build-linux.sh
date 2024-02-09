#!/bin/bash
./onnxruntime/build.sh \
--config=MinSizeRel \
--build_shared_lib \
--parallel \
--minimal_build \
--disable_ml_ops --disable_exceptions --disable_rtti \
--skip_tests
