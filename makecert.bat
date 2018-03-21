@echo off

:: Author :     Rahul Thakare
:: Github :     https://github.com/bantya/MakeCert
:: Purpose :    Create self-signed ssl certificates
:: Based on :   https://gist.github.com/vikas5914/f4384d12866fd572bfc5bcf389e756e8#file-makecert-bat

set VERSION=2.0.0
set OPTION=%1
set SECOND_OPTION=%2

set CONFIG_FILE=%USERPROFILE%\makecert-config.ini
set CONFIG_TEMP=%TEMP%\makecert-config.txt

set HOSTNAME=""
set DOT=""
set COUNTRY=""
set STATE=""
set CITY=""
set ORGANIZATION=""
set ORGANIZATION_UNIT=""
set EMAIL=""

title OpenSSL Cert Creator v%VERSION%

if "%OPTION%" equ "--help" (
    goto ShowHelp
)
if "%OPTION%" equ "-h" (
    goto ShowHelp
)

if "%OPTION%" equ "--set-config" (
    goto SetConfig
)
if "%OPTION%" equ "-s" (
    goto SetConfig
)

if "%OPTION%" equ "--open-repo" (
    start https://github.com/bantya/MakeCert
    goto :EOF
)
if "%OPTION%" equ "-o" (
    start https://github.com/bantya/MakeCert
    goto :EOF
)

echo.
echo Welcome to OpenSSL Cert Creator v%VERSION% by www.github.com/bantya
echo NOTE: Info entered must not contain any blank-space ( ), use hyphen (-) or underscore (_) instead!
echo.

goto EnterInfo

:EnterInfo

set HOSTNAME=''
echo What's your hostname? (domain)
set /p HOSTNAME=
if %HOSTNAME%=='' (
    set HOSTNAME=domain
)

set DOT=''
echo What's your domain extension? (.test)
set /p DOT=
if %DOT%=='' (
    set DOT=test
)

if %DOT:~0,1%==. (
    set DOT=%DOT:~1%
)

if "%OPTION%" equ "--use-config" (
    goto GetConfig
)
if "%OPTION%" equ "-c" (
    goto GetConfig
)

set COUNTRY=''
echo What's your country? (IN)
set /p COUNTRY=
if %COUNTRY%=='' (
    set COUNTRY=IN
)

set STATE=''
echo What's your state? (MH)
set /p STATE=
if %STATE%=='' (
    set STATE=MH
)

set CITY=''
echo What's your city? (Mumbai)
set /p CITY=
if %CITY%=='' (
    set CITY=Mumbai
)

set ORGANIZATION=''
echo What's your organization? (IT)
set /p ORGANIZATION=
if %ORGANIZATION%=='' (
    set ORGANIZATION=IT
)

set ORGANIZATION_UNIT=''
echo What's your organization unit? (IT Department)
set /p ORGANIZATION_UNIT=
if %ORGANIZATION_UNIT%=='' (
    set ORGANIZATION_UNIT=IT Department
)

set EMAIL=''
echo What's your email? (administrator@%HOSTNAME%.%DOT%)
set /p EMAIL=
if %EMAIL%=='' (
    set EMAIL=administrator@%HOSTNAME%.%DOT%
)

:DisplayInfo

echo.
echo Hostname : %HOSTNAME%
echo Dot : %DOT%
echo Country : %COUNTRY%
echo State : %STATE%
echo City : %CITY%
echo Organization : %ORGANIZATION%
echo Organization_unit : %ORGANIZATION_UNIT%
echo Email : %EMAIL%

echo.
echo Does this looks good to you?
echo If yes press y to proceed else press n to fill the info again!
echo.

SET /P CHOICE=Would you like to continue? (y/n) :
if /i "%CHOICE%"=="n" (
    cls
    goto EnterInfo
) else if /i "%CHOICE%"=="y" (
    goto ProceedAhead
)

:ProceedAhead

echo.
(
echo [req]
echo default_bits = 2048
echo prompt = no
echo default_md = sha256
echo x509_extensions = v3_req
echo distinguished_name = dn
echo:
echo [dn]
echo C = %COUNTRY%
echo ST = %STATE%
echo L = %CITY%
echo O = %ORGANIZATION%
echo OU = %ORGANIZATION_UNIT%
echo emailAddress = %EMAIL%
echo CN = %HOSTNAME%.%DOT%
echo:
echo [v3_req]
echo subjectAltName = @alt_names
echo:
echo [alt_names]
echo DNS.1 = *.%HOSTNAME%.%DOT%
echo DNS.2 = %HOSTNAME%.%DOT%
) > %HOSTNAME%.%DOT%.cnf

call openssl req -new -x509 -newkey rsa:2048 -sha256 -nodes -keyout %HOSTNAME%.%DOT%.key -days 3560 -out %HOSTNAME%.%DOT%.crt -config %HOSTNAME%.%DOT%.cnf

if "%OPTION%" equ "--no-cfg" (
    del /q %HOSTNAME%.%DOT%.cnf
)
if "%OPTION%" equ "-n" (
    del /q %HOSTNAME%.%DOT%.cnf
)

if errorlevel 1 (
    goto ErrorMessage
)

echo.
echo Generated your %HOSTNAME%.%DOT%.key %HOSTNAME%.%DOT%.cnf %HOSTNAME%.%DOT%.crt .
goto OpenFolder

:ErrorMessage

echo.
echo Some error occured.
echo Could not generate some files.
goto OpenFolder

:OpenFolder

echo Opening containing folder..
start .
pause
goto :EOF

:GetConfig

for /f "tokens=1,2 delims==" %%a in (%CONFIG_FILE%) do (
    set %%a=%%b
)
goto DisplayInfo

:SetConfig

echo.Set your config fields here.
echo.
set COUNTRY=IN
echo What's your country? (IN)
set /p COUNTRY=
echo COUNTRY=%COUNTRY%>>%CONFIG_TEMP%

set STATE=MH
echo What's your state? (MH)
set /p STATE=
echo STATE=%STATE%>>%CONFIG_TEMP%

set CITY=Mumbai
echo What's your city? (Mumbai)
set /p CITY=
echo CITY=%CITY%>>%CONFIG_TEMP%

set ORGANIZATION=IT
echo What's your organization? (IT)
set /p ORGANIZATION=
echo ORGANIZATION=%ORGANIZATION%>>%CONFIG_TEMP%

set ORGANIZATION_UNIT=IT Department
echo What's your organization unit? (IT Department)
set /p ORGANIZATION_UNIT=
echo ORGANIZATION_UNIT=%ORGANIZATION_UNIT%>>%CONFIG_TEMP%

set EMAIL=administrator@site.com
echo What's your email? (administrator@site.com)
set /p EMAIL=
echo EMAIL=%EMAIL%>>%CONFIG_TEMP%

echo.
echo. COUNTRY=%COUNTRY%
echo. STATE=%STATE%
echo. CITY=%CITY%
echo. ORGANIZATION=%ORGANIZATION%
echo. ORGANIZATION_UNIT=%ORGANIZATION_UNIT%
echo. EMAIL=%EMAIL%

echo.
echo Does this looks good to you?
echo If yes press y to proceed else press n to provide fields again!
echo.

SET /P CHOICE=Would you like to continue? (y/n) :
if /i "%CHOICE%"=="n" (
    cls
    del /q %CONFIG_TEMP%
    goto SetConfig
) else if /i "%CHOICE%"=="y" (
    goto CopyConfig
)

:CopyConfig

type %CONFIG_TEMP% > %CONFIG_FILE%
del /q %CONFIG_TEMP%
echo.
echo.Config fields set successfully!
goto :EOF

:ShowHelp

echo.Usage:
echo.
echo.   makecert [options]
echo.
echo.Options:
echo.
echo.   --no-cfg -n         Do not create the .cfg file.
echo.
echo.   --use-config -c     Use the config file to prepopulate secondary fields.
echo.                       Default: %CONFIG_FILE%
echo.
echo.   --set-config -s     Set the secondary fields in config file.
echo.                       Set to: %CONFIG_FILE%
echo.
echo.   --open-repo -o      Open the project repo in the browser.
echo.                       Repo link: https://github.com/bantya/MakeCert
echo.
echo.   --help -h           Show the help dialog.
echo.
exit /b
