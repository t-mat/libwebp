@echo off
setlocal enabledelayedexpansion
set /a errorno=1
for /F "delims=#" %%E in ('"prompt #$E# & for %%E in (1) do rem"') do set "esc=%%E"
cd /d "%~dp0"

:
set /a _E =0 && set "_P=Config and Init"
:
set /a _E+=1 && set "BUILD_CMAKE_DIR=build"
set /a _E+=1 && set "BUILD_ROOT_DIR=!CD!"
set /a _E+=1 && where /q cmake.exe       || goto :ERROR
set /a _E+=1 && cd /d "!BUILD_ROOT_DIR!" || goto :ERROR
set /a _E+=1 && if     exist "!BUILD_CMAKE_DIR!" ( rd /q /s "!BUILD_CMAKE_DIR!" >nul 2>&1 )
set /a _E+=1 && if not exist "!BUILD_CMAKE_DIR!" ( md "!BUILD_CMAKE_DIR!" >nul 2>&1 )
set /a _E+=1 && if not exist "!BUILD_CMAKE_DIR!" ( goto :ERROR )

:
set /a _E =0 && set "_P=Build"
:
set /a _E+=1 && cd /d "!BUILD_ROOT_DIR!" || goto :ERROR
:
set /a _E+=1 && set "_CL_=/utf-8"
set /a _E+=1 && set "MSBUILD_OPTS=/nologo /m /verbosity:minimal /consoleloggerparameters:ErrorsOnly"
:
set /a _E+=1 && echo Building static libwebp.lib, msvc runtime = x64_MultiThreaded_MT
set /a _E+=1 && cmake -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=OFF -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded            || goto :ERROR
set /a _E+=1 && cmake --build "!BUILD_CMAKE_DIR!" --config RelWithDebInfo --clean-first --parallel -- !MSBUILD_OPTS!            || goto :ERROR
set /a _E+=1 && xcopy /y /i /q !BUILD_CMAKE_DIR!\RelWithDebInfo\*.* !BUILD_CMAKE_DIR!\artifacts\lib\static_x64_MultiThreaded_MT || goto :ERROR
:
set /a _E+=1 && echo Building static libwebp.lib, msvc runtime = x64_MultiThreadedDebug_MTd
set /a _E+=1 && cmake -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=OFF -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDebug    || goto :ERROR
set /a _E+=1 && cmake --build "!BUILD_CMAKE_DIR!" --config Debug --clean-first -- !MSBUILD_OPTS!                             || goto :ERROR
set /a _E+=1 && xcopy /y /i /q !BUILD_CMAKE_DIR!\Debug\*.* !BUILD_CMAKE_DIR!\artifacts\lib\static_x64_MultiThreadedDebug_MTd || goto :ERROR
:
set /a _E+=1 && echo Building static libwebp.lib, msvc runtime = x64_MultiThreadedDLL_MD
set /a _E+=1 && cmake -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=OFF -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDLL            || goto :ERROR
set /a _E+=1 && cmake --build "!BUILD_CMAKE_DIR!" --config RelWithDebInfo --clean-first --parallel -- !MSBUILD_OPTS!               || goto :ERROR
set /a _E+=1 && xcopy /y /i /q !BUILD_CMAKE_DIR!\RelWithDebInfo\*.* !BUILD_CMAKE_DIR!\artifacts\lib\static_x64_MultiThreadedDLL_MD || goto :ERROR
:
set /a _E+=1 && echo Building static libwebp.lib, msvc runtime = x64_MultiThreadedDebugDLL_MDd
set /a _E+=1 && cmake -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=OFF -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDebugDLL    || goto :ERROR
set /a _E+=1 && cmake --build "!BUILD_CMAKE_DIR!" --config Debug --clean-first -- !MSBUILD_OPTS!                                || goto :ERROR
set /a _E+=1 && xcopy /y /i /q !BUILD_CMAKE_DIR!\Debug\*.* !BUILD_CMAKE_DIR!\artifacts\lib\static_x64_MultiThreadedDebugDLL_MDd || goto :ERROR
:
set /a _E+=1 && echo Building DLL libwebp.lib+dll, msvc runtime = x64_MultiThreaded_MT
set /a _E+=1 && cmake -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=ON -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded          || goto :ERROR
set /a _E+=1 && cmake --build "!BUILD_CMAKE_DIR!" --config RelWithDebInfo --clean-first --parallel -- !MSBUILD_OPTS!         || goto :ERROR
set /a _E+=1 && xcopy /y /i /q !BUILD_CMAKE_DIR!\RelWithDebInfo\*.* !BUILD_CMAKE_DIR!\artifacts\lib\DLL_x64_MultiThreaded_MT || goto :ERROR
:
set /a _E+=1 && echo Building DLL libwebp.lib+dll, msvc runtime = x64_MultiThreadedDebug_MTd
set /a _E+=1 && cmake -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=ON -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDebug  || goto :ERROR
set /a _E+=1 && cmake --build "!BUILD_CMAKE_DIR!" --config Debug --clean-first --parallel -- !MSBUILD_OPTS!               || goto :ERROR
set /a _E+=1 && xcopy /y /i /q !BUILD_CMAKE_DIR!\Debug\*.* !BUILD_CMAKE_DIR!\artifacts\lib\DLL_x64_MultiThreadedDebug_MTd || goto :ERROR
:
set /a _E+=1 && echo Building DLL libwebp.lib+dll, msvc runtime = x64_MultiThreadedDLL_MD
set /a _E+=1 && cmake -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=ON -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDLL          || goto :ERROR
set /a _E+=1 && cmake --build "!BUILD_CMAKE_DIR!" --config RelWithDebInfo --clean-first --parallel -- !MSBUILD_OPTS!            || goto :ERROR
set /a _E+=1 && xcopy /y /i /q !BUILD_CMAKE_DIR!\RelWithDebInfo\*.* !BUILD_CMAKE_DIR!\artifacts\lib\DLL_x64_MultiThreadedDLL_MD || goto :ERROR
:
set /a _E+=1 && echo Building DLL libwebp.lib+dll, msvc runtime = x64_MultiThreadedDebugDLL_MDd
set /a _E+=1 && cmake -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=ON -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDebugDLL  || goto :ERROR
set /a _E+=1 && cmake --build "!BUILD_CMAKE_DIR!" --config Debug --clean-first --parallel -- !MSBUILD_OPTS!                  || goto :ERROR
set /a _E+=1 && xcopy /y /i /q !BUILD_CMAKE_DIR!\Debug\*.* !BUILD_CMAKE_DIR!\artifacts\lib\DLL_x64_MultiThreadedDebugDLL_MDd || goto :ERROR


:
set /a _E =0 && set "_P=Copy artifacts"
:
set /a _E+=1 && cd /d "!BUILD_ROOT_DIR!" || goto :ERROR
set /a _E+=1 && xcopy /y /i /q src\webp\*.* !BUILD_CMAKE_DIR!\artifacts\include\webp\
set /a _E+=1 && xcopy /y /i /q doc\*.*      !BUILD_CMAKE_DIR!\artifacts\doc\
set /a _E+=1 && xcopy /y /i /q Changelog    !BUILD_CMAKE_DIR!\artifacts\
set /a _E+=1 && xcopy /y /i /q COPYING      !BUILD_CMAKE_DIR!\artifacts\
set /a _E+=1 && xcopy /y /i /q NEWS         !BUILD_CMAKE_DIR!\artifacts\
set /a _E+=1 && xcopy /y /i /q README.md    !BUILD_CMAKE_DIR!\artifacts\
set /a _E+=1 && git rev-parse HEAD        > !BUILD_CMAKE_DIR!\artifacts\commit-hash

set /a _E+=1 && set "ARTIFACT_PATH=!BUILD_ROOT_DIR!\!BUILD_CMAKE_DIR!\artifacts"
set /a _E+=1 && set "ARTIFACT_URL=file://!ARTIFACT_PATH:\=/!"

echo.
echo All artifacts are in !esc![92m!ARTIFACT_URL!!esc![0m
echo.


echo Build Status -!esc![92m SUCCEEDED !esc![0m
set /a errorno=0
goto :END

:ERROR
echo Abort by error.
echo.
echo Build Status -!esc![91m ERROR - _P=!_P! ( _E=!_E! ) !esc![0m !esc![0m

:END
exit /B !errorno!
