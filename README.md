## Added notes:

 1. WASM build broken (macOS/Win?), may require `iconv` install and/or building from Linux, see: https://github.com/microsoft/onnxruntime/issues/17135  
 2. Android build was added for the four possible Android architectures 
 	- Add equivalent of the following to your shell profile if not already there:
	```export ANDROID_HOME=/Users/<user_name>/Library/Android/sdk```
	```export ANDROID_NDK_HOME=/Users/<user_name>/Library/Android/sdk/ndk/25.2.9519653```
	- When building add one of four architectures as additional argument, i.e.
	```./build-android.sh {arm64-v8a, armeabi-v7a, x86, x86_64}```
	- CombineArchives step is WIP for Android (will need to be run from Linux)


# ONNX Runtime static library builder

Converts an [ONNX](https://onnx.ai) model to ORT format and serializes it to C++ source code, generate custom slimmed ONNX Runtime static libs & xcframework for apple platforms.

The goal here is to create a flexible but tiny inference engine for use in Audio Plug-ins or Mobile apps e.g. [iPlug2 example](https://github.com/olilarkin/iPlug2OnnxRuntime).

The scripts here are configured to create a minimal ORT binary using only the CPU provider. If you want to experiment with GPU inference, Core ML etc, you will have to modify 

## Instructions:

1. Checkout ONNX Runtime `$ git clone https://github.com/microsoft/onnxruntime.git`

2. Place your model in the folder named model.onnx

3. Create a [virtual environment](https://packaging.python.org/tutorials/installing-packages/#creating-virtual-environments) `$ python3 -m venv venv`

4. Activate it `$ source ./venv/bin/activate`

5. Install dependencies `$ pip install -r requirements.txt`

6. Run `$ ./convert-model-to-ort.sh model.onnx`

7. Build static libraries using one of the `build-xxx.sh` shell scripts
