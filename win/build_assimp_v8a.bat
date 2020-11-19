@echo off
cls

REM *NOTE* Change these based on 
SET ASSIMP_DIR=../assimp
SET API=24
REM ARCH arm arm64 x86 x86_64
SET ARCH=arm64
REM ARCH armeabi-v7a arm64-v8a x86 x86_64
SET ARCH_ABI=arm64-v8a
SET OUTPUT_DIR=assimp-build-%ARCH%
SET ANDROID_PATH=D:\Develop\sdk
SET NDK_PATH=D:\Develop\ndk\android-ndk-r21
SET NDK_TOOLCHAIN=%~dp0android-toolchain-%API%-llvm-%ARCH%
SET CMAKE_TOOLCHAIN=%NDK_PATH%\build\cmake\android.toolchain.cmake
SET CMAKE_PATH=%ANDROID_PATH%\cmake\3.10.2.4988404

del -rf %NDK_TOOLCHAIN% < Y
python %NDK_PATH%/build/tools/make_standalone_toolchain.py --arch=%ARCH% --stl=libc++ --api=%API% --install-dir=%NDK_TOOLCHAIN%

REM *NOTE* Careful if you don't want rm -rf, I use it for testing purposes.
del -rf %OUTPUT_DIR% < Y
mkdir %OUTPUT_DIR%

REM pushd doesn't seem to work ):<
cd %OUTPUT_DIR%

if not defined ORIGPATH set ORIGPATH=%PATH%
SET PATH=%CMAKE_PATH%\bin;%ANDROID_PATH%\tools;%ANDROID_PATH%\platform-tools;%ORIGPATH%

cmake ^
      -GNinja ^
      -DCMAKE_TOOLCHAIN_FILE=%CMAKE_TOOLCHAIN% ^
      -DASSIMP_ANDROID_JNIIOSYSTEM=ON ^
      -DANDROID_NDK=%NDK_PATH% ^
      -DCMAKE_MAKE_PROGRAM=%CMAKE_PATH%\bin\ninja.exe ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DANDROID_ABI="%ARCH_ABI%" ^
      -DANDROID_NATIVE_API_LEVEL=%API% ^
      -DANDROID_FORCE_ARM_BUILD=TRUE ^
      -DCMAKE_INSTALL_PREFIX=install ^
      -DANDROID_STL=c++_shared ^
      -DCMAKE_CXX_FLAGS=-Wno-c++11-narrowing ^
      -DANDROID_TOOLCHAIN=clang ^

      -DASSIMP_BUILD_TESTS=OFF ^

      ../%ASSIMP_DIR%

cmake --build .

cd ..

pause
