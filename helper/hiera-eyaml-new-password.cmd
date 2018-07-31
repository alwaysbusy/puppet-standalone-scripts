@ECHO OFF

SET length=32

FOR /F "tokens=* USEBACKQ" %%F IN (`powershell -Command "([char[]]([char]33..[char]95) + ([char[]]([char]97..[char]126)) + 0..9 | sort {Get-Random})[0..%length%] -join ''"`) DO (
SET var="%%F%"
)
ECHO Unencrypted - %var%
"%programfiles%\Puppet Labs\Puppet\sys\ruby\bin\eyaml" encrypt -s %var%
SET /p DUMMY=Press Enter to exit...
