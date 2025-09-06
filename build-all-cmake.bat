@echo off
setlocal enabledelayedexpansion
set /a errorno=1
for /F "delims=#" %%E in ('"prompt #$E# & for %%E in (1) do rem"') do set "esc=%%E"
cd /d "%~dp0"
set _=set /a _LINE_NUMBER+=1
set /a _LINE_NUMBER =7
!_!
!_!&& set "BUILD_CMAKE_DIR=build"
!_!&& set "BUILD_ROOT_DIR=!CD!"
!_!&& where /q cmake.exe       || goto :ERROR
!_!&& cd /d "!BUILD_ROOT_DIR!" || goto :ERROR
!_!&& if     exist "!BUILD_CMAKE_DIR!" ( rd /q /s "!BUILD_CMAKE_DIR!" >nul 2>&1 )
!_!&& if not exist "!BUILD_CMAKE_DIR!" ( md "!BUILD_CMAKE_DIR!" >nul 2>&1 )
!_!&& if not exist "!BUILD_CMAKE_DIR!" ( goto :ERROR )
!_!
!_!&& cd /d "!BUILD_ROOT_DIR!" || goto :ERROR
!_!
!_!&& set "_CL_=/utf-8"
!_!&& set "MSBUILD_OPTS=/nologo /m /verbosity:minimal /consoleloggerparameters:ErrorsOnly"
!_!
!_!&& echo.
!_!&& echo !esc![92m Building static libwebp.lib, msvc runtime = x64_MultiThreaded_MT !esc![0m
!_!&& cmake --log-level WARNING -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=OFF -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded          || goto :ERROR
!_!&& cmake --build "!BUILD_CMAKE_DIR!" --config RelWithDebInfo --clean-first --parallel -- !MSBUILD_OPTS!                              || goto :ERROR
!_!&& xcopy /y /i /q !BUILD_CMAKE_DIR!\RelWithDebInfo\*.* !BUILD_CMAKE_DIR!\artifacts\lib\static_x64_MultiThreaded_MT                   || goto :ERROR
!_!
!_!&& echo.
!_!&& echo !esc![92m Building static libwebp.lib, msvc runtime = x64_MultiThreadedDebug_MTd !esc![0m
!_!&& cmake --log-level WARNING -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=OFF -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDebug     || goto :ERROR
!_!&& cmake --build "!BUILD_CMAKE_DIR!" --config Debug --clean-first -- !MSBUILD_OPTS!                                                  || goto :ERROR
!_!&& xcopy /y /i /q !BUILD_CMAKE_DIR!\Debug\*.* !BUILD_CMAKE_DIR!\artifacts\lib\static_x64_MultiThreadedDebug_MTd                      || goto :ERROR
!_!
!_!&& echo.
!_!&& echo !esc![92m Building static libwebp.lib, msvc runtime = x64_MultiThreadedDLL_MD !esc![0m
!_!&& cmake --log-level WARNING -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=OFF -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDLL       || goto :ERROR
!_!&& cmake --build "!BUILD_CMAKE_DIR!" --config RelWithDebInfo --clean-first --parallel -- !MSBUILD_OPTS!                              || goto :ERROR
!_!&& xcopy /y /i /q !BUILD_CMAKE_DIR!\RelWithDebInfo\*.* !BUILD_CMAKE_DIR!\artifacts\lib\static_x64_MultiThreadedDLL_MD                || goto :ERROR
!_!
!_!&& echo.
!_!&& echo !esc![92m Building static libwebp.lib, msvc runtime = x64_MultiThreadedDebugDLL_MDd !esc![0m
!_!&& cmake --log-level WARNING -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=OFF -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDebugDLL  || goto :ERROR
!_!&& cmake --build "!BUILD_CMAKE_DIR!" --config Debug --clean-first -- !MSBUILD_OPTS!                                                  || goto :ERROR
!_!&& xcopy /y /i /q !BUILD_CMAKE_DIR!\Debug\*.* !BUILD_CMAKE_DIR!\artifacts\lib\static_x64_MultiThreadedDebugDLL_MDd                   || goto :ERROR
!_!
!_!&& echo.
!_!&& echo !esc![92m Building DLL libwebp.lib+dll, msvc runtime = x64_MultiThreaded_MT !esc![0m
!_!&& cmake --log-level WARNING -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=ON -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded           || goto :ERROR
!_!&& cmake --build "!BUILD_CMAKE_DIR!" --config RelWithDebInfo --clean-first --parallel -- !MSBUILD_OPTS!                              || goto :ERROR
!_!&& xcopy /y /i /q !BUILD_CMAKE_DIR!\RelWithDebInfo\*.* !BUILD_CMAKE_DIR!\artifacts\lib\DLL_x64_MultiThreaded_MT                      || goto :ERROR
!_!
!_!&& echo.
!_!&& echo !esc![92m Building DLL libwebp.lib+dll, msvc runtime = x64_MultiThreadedDebug_MTd !esc![0m
!_!&& cmake --log-level WARNING -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=ON -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDebug      || goto :ERROR
!_!&& cmake --build "!BUILD_CMAKE_DIR!" --config Debug --clean-first --parallel -- !MSBUILD_OPTS!                                       || goto :ERROR
!_!&& xcopy /y /i /q !BUILD_CMAKE_DIR!\Debug\*.* !BUILD_CMAKE_DIR!\artifacts\lib\DLL_x64_MultiThreadedDebug_MTd                         || goto :ERROR
!_!
!_!&& echo.
!_!&& echo !esc![92m Building DLL libwebp.lib+dll, msvc runtime = x64_MultiThreadedDLL_MD !esc![0m
!_!&& cmake --log-level WARNING -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=ON -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDLL        || goto :ERROR
!_!&& cmake --build "!BUILD_CMAKE_DIR!" --config RelWithDebInfo --clean-first --parallel -- !MSBUILD_OPTS!                              || goto :ERROR
!_!&& xcopy /y /i /q !BUILD_CMAKE_DIR!\RelWithDebInfo\*.* !BUILD_CMAKE_DIR!\artifacts\lib\DLL_x64_MultiThreadedDLL_MD                   || goto :ERROR
!_!
!_!&& echo.
!_!&& echo !esc![92m Building DLL libwebp.lib+dll, msvc runtime = x64_MultiThreadedDebugDLL_MDd !esc![0m
!_!&& cmake --log-level WARNING -S . -B "!BUILD_CMAKE_DIR!" -DBUILD_SHARED_LIBS=ON -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDebugDLL   || goto :ERROR
!_!&& cmake --build "!BUILD_CMAKE_DIR!" --config Debug --clean-first --parallel -- !MSBUILD_OPTS!                                       || goto :ERROR
!_!&& xcopy /y /i /q !BUILD_CMAKE_DIR!\Debug\*.* !BUILD_CMAKE_DIR!\artifacts\lib\DLL_x64_MultiThreadedDebugDLL_MDd                      || goto :ERROR
!_!
!_!
!_!&& cd /d "!BUILD_ROOT_DIR!" || goto :ERROR
!_!&& xcopy /y /i /q src\webp\*.* !BUILD_CMAKE_DIR!\artifacts\include\webp\
!_!&& xcopy /y /i /q doc\*.*      !BUILD_CMAKE_DIR!\artifacts\doc\
!_!&& xcopy /y /i /q Changelog    !BUILD_CMAKE_DIR!\artifacts\
!_!&& xcopy /y /i /q COPYING      !BUILD_CMAKE_DIR!\artifacts\
!_!&& xcopy /y /i /q NEWS         !BUILD_CMAKE_DIR!\artifacts\
!_!&& xcopy /y /i /q README.md    !BUILD_CMAKE_DIR!\artifacts\
!_!&& git rev-parse HEAD        > !BUILD_CMAKE_DIR!\artifacts\commit-hash
!_!
!_!&& set "ARTIFACT_PATH=!BUILD_ROOT_DIR!\!BUILD_CMAKE_DIR!\artifacts"
!_!&& set "ARTIFACT_URL=file://!ARTIFACT_PATH:\=/!"
!_!

echo.
echo All artifacts are in !esc![92m!ARTIFACT_URL!!esc![0m
echo.


echo Build Status -!esc![92m SUCCEEDED !esc![0m
set /a errorno=0
goto :END

:ERROR
echo Abort by error.
echo.
echo Build Status -!esc![91m ERROR ( Line number=!_LINE_NUMBER! ) !esc![0m !esc![0m

:END
exit /B !errorno!
