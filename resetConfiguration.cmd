@echo off
SETLOCAL
set DotNetDir=%windir%\Microsoft.NET\Framework\v4.0.30319%
set MSBuildExe=%DotNetDir%\msbuild.exe

IF NOT EXIST "%DotNetDir%" GOTO :NODOTNET
IF NOT EXIST "%MSBuildExe%" GOTO :NODOTNET

%MSBuildExe% Sp.Samples.BuildIntegration\Sp.Samples.BuildIntegration/Sp.Samples.BuildIntegration.csproj /t:StripPermutationInfo
%MSBuildExe% Sp.Samples.BuildIntegration\Sp.Samples.BuildIntegration.Library/Sp.Samples.BuildIntegration.Library.csproj /t:StripPermutationInfo

IF ERRORLEVEL 1 GOTO :ERROR

echo Sp.Samples.BuildIntegration permutation configuration has been reset.
echo If you have your solution open in Visual Studio 2010, please Close and re-open it now (Visual Studio caches .targets files that were modified during this operation)
GOTO :EOF

:NODOTNET
ECHO Error: Could not locate MSBuild. Looked in %DotNetDir%
GOTO :EOF

:ERROR
ECHO ON
EXIT /b %ERRORLEVEL%

:EOF