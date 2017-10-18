REM Cycle the local Consul instance and restart IIS
SET dir=C:\consul\data
net stop consul.io
del /q %dir%\*
for /d %%x in (%dir%\*) do @rd /s /q "%%x"
net start consul.io
iisreset