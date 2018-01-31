@echo off

:: Author :     Rahul Thakare
:: Github :     https://github.com/bantya/MakeCert
:: Purpose :    Create self-signed ssl certificates
:: Based on :   https://gist.github.com/vikas5914/f4384d12866fd572bfc5bcf389e756e8#file-makecert-bat

set VERSION=1.0.0

title OpenSSL Cert Creator v%VERSION%

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
echo What's your domain extension? (.com)
set /p DOT=
if %DOT%=='' (
    set DOT=com
)

if %DOT:~0,1%==. (
    set DOT=%DOT:~1%
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
echo Does this info looks good to you?
echo If yes press y to proceed else press n to fill the info again!

SET /P CHOICE=Would you like to continue? (y/n):
if /i %CHOICE%==n (
    cls
    goto EnterInfo
)
if /i %CHOICE%==y goto ProceedAhead

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
