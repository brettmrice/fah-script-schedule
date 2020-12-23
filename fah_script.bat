@echo off

set fahStatus=notRunning

:loop

if %time% geq 06:00 (
  if %time% leq 19:00 (
    if "%fahStatus%" equ "notRunning" (
      goto SendResume
    )
    goto ScriptRunning
  ) else (
    if "%fahStatus%" equ "isRunning" (
      goto SendFinish
    )
    goto ScriptWaiting
  )
)

goto loop

:SendResume
echo Send Resume
fahclient --send-unpause
set fahStatus=isRunning
goto loop

:SendFinish
echo Send Finish
fahclient --send-finish
set fahStatus=notRunning
goto loop

:ScriptRunning
cls
echo Current time is %time:~0,8%
echo FAH is currently running. Waiting till 19:00 to send Finish command.
sleep 1
goto loop

:ScriptWaiting
cls
echo Current time is %time:~0,8%
echo FAH is currently paused. Waiting till 06:00 to send Resume command.
sleep 1
goto loop
