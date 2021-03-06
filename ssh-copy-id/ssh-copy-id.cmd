:: from http://serverfault.com/questions/224810/is-there-an-equivalent-to-ssh-copy-id-for-windows
:: expected parameters
:: user@host.com password [id_ras.pub]
::usage: ssh-copy-id test@example.com password [identity file]

::@echo off
IF "%~3"=="" GOTO setdefault
set id=%3
GOTO checkparams
:setdefault
set id=id_rsa.pub
:checkparams
IF "%~1"=="" GOTO promptp
IF "%~2"=="" GOTO promptp2

:exec
:: To accept the signature the first time
echo y | plink.exe %1 -pw %2 "exit"
:: now to actually copy the key
echo type %id% | plink.exe %1 -pw %2 "umask 077; test -d .ssh || mkdir .ssh ; cat >> .ssh/authorized_keys"
GOTO end

:promptp
set /p 1="Enter username@remotehost.com: "
:promptp2
set /p 2="Enter password: "
GOTO exec

:end
pause