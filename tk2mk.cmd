@echo off
title Thunkable to Makeroid AIA converter (%~n0)

if "%~1" == "" (
	echo Drop an AIA file to %~nx0 or type "%~n0 <AIA file>" in the terminal
	pause
) else (
	echo Converting %~nx1 to Makeroid...
	if exist "%~n0_temp" (
		rd /s /q "%~n0_temp"
	)
	md "%~n0_temp"
	attrib +h "%~n0_temp"
	7z x "%~1" -o"%cd%\%~n0_temp" > nul
	REM "%programfiles%\7-Zip\7z" x "%~1" -o"%cd%\%~n0_temp" > nul
	
	cd "%~n0_temp\src\com\"
	for /f usebackq %%s in (`dir /b "*"`) do cd %%s
	for /f usebackq %%s in (`dir /b "*"`) do cd %%s
	setlocal enabledelayedexpansion
	for /f usebackq %%s in (`dir /b/s "*"`) do (
		set /p r=<%%s
		set r=!r:ThunkablePushNotification=PushNotifications!
		set r=!r:ThunkableFloatingActionButton=MakeroidFab!
		set r=!r:ThunkableAdMobInterstitial=AdMobInterstitial!
		set r=!r:ThunkableAdMobBanner=AdmobBanner!
		set r=!r:ThunkableSwitch","$Version":"6=SwitchToggle","$Version":"3!
		set r=!r:ThunkableSwitch=SwitchToggle!
		echo !r!>%%s
	)
	
	cd ..\..\..\..\..\
	7z a -tzip "%~n1_makeroid.aia" "%cd%\%~n0_temp\*" > nul
	REM "%programfiles%\7-Zip\7z" a -tzip "%~n1_makeroid.aia" "%cd%\%~n0_temp\*"" > nul
	rd /s /q "%~n0_temp"
	echo Done! You can import %~n1_makeroid.aia in Makeroid.
	pause
)