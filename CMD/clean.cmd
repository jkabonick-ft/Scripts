REM Delete all the contents of the specified folder
SET dir=%1
del /q %dir%\*
for /d %%x in (%dir%\*) do @rd /s /q "%%x"
EXIT /B 0