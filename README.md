## Added notes:

### macOS
1. The following patch should be applied: `https://github.com/microsoft/onnxruntime/issues/18036#issuecomment-1869894544` TODO: apply automatically
2. The following homebrew packages interfere with the build process if installed! `protobuf, abseil`

### iOS

### Linux

### Android
 1. Android build was added for the four possible Android architectures 
 	- Add equivalent of the following to your shell profile if not already there:
	```export ANDROID_HOME=/Users/<user_name>/Library/Android/sdk```
	```export ANDROID_NDK_HOME=/Users/<user_name>/Library/Android/sdk/ndk/25.2.9519653```
	- When building add one of four architectures as additional argument, i.e.
	```./build-android.sh {arm64-v8a, armeabi-v7a, x86, x86_64}```
	- CombineArchives step is WIP for Android (will need to be run from Linux)

### WASM
 1. WASM build broken (macOS/Win?), may require `iconv` install and/or building from Linux, see: https://github.com/microsoft/onnxruntime/issues/17135  



# ONNX Runtime static library builder

Converts an [ONNX](https://onnx.ai) model to ORT format and serializes it to C++ source code, generate custom slimmed ONNX Runtime static libs & xcframework for apple platforms.

The goal here is to create a flexible but tiny inference engine for a specific model for use in Audio Plug-ins or Mobile apps e.g. [iPlug2 example](https://github.com/olilarkin/iPlug2OnnxRuntime).

The scripts here are configured to create a minimal ORT binary using only the CPU provider. If you want to experiment with GPU inference, Core ML etc, you will have to modify.

## Requirements:

CMake v2.6+

## Instructions:

1. Checkout ONNX Runtime submodule `$ git submodule update --init`

2. Create a [virtual environment](https://packaging.python.org/tutorials/installing-packages/#creating-virtual-environments) and activate it

```windows (bash shell)
$ py -3 -m venv env
$ source ./venv/Scripts/activate`
```

```mac/linux
$ python3 -m venv venv
$ source ./venv/bin/activate`
```

3. Install dependencies `$ pip install -r requirements.txt`

4. Run `$ ./convert-model-to-ort.sh model.onnx`
This converts the .onnx file to .ort and produces a .config file which slims the onnxruntime library build in the next step.
It also serializes the .ort format model to C++ source code, which can be used to bake the model into your app binary. If the model
is large this might not be a great solution, and it might be better to locate the .ort file at runtime.

6. Build customized onnx runtime static libraries

```mac
$ ./build-mac.sh
```

```ios
$ ./build-ios.sh
$ ./build-ios-simulator.sh
```

```xcframework build
$ ./build-xcframework.sh
```

**Note:** windows static lib builds can get very large due to the LTO/LTCG settings in onnxruntime. 
You can turn that off by applying the change in ltcg_patch_for_windows.patch to the onnxruntime repo.
Due to different MSVC runtimes for Debug and Release builds, we need to build two binaries for windows.

```windows
$ ./build-win.sh
```
