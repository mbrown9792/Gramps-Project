@echo off

setlocal EnableDelayedExpansion

set yyyy=%date:~10,4%
set mm=%date:~4,2%
set dd=%date:~7,2%

set hh=%time:~0,2%
set min=%time:~3,2%
set ss=%time:~6,2%

set stamp=%yyyy%%mm%%dd%-%hh%%min%%ss%

cd \Users\mbrown\AppData\Roaming\gramps\grampsdb\
dir /A:D /B 1> "\Users\mbrown\Documents\Gramps-Files\tree_lists\tree_list_%stamp%.txt" 2>&1

cd \Users\mbrown\Documents\Gramps-Files\tree_lists\
for /f "delims=" %%A in (tree_list_%stamp%.txt) do (
	
	cd \Users\mbrown\AppData\Roaming\gramps\grampsdb\%%~nA\
	for /F "delims=" %%B in (name.txt) do (
	
		set path=\Users\mbrown\Documents\Gramps-Files\backups\biweekly_tree_backups\%%B
		
		if not exist !path! (
			mkdir !path!
		)
		
		cd \Program Files\Gramps
		gramps -y -u --open="%%B" --export="!path!\%%B_%stamp%.ged" 1> "\Users\mbrown\Documents\Gramps-Files\logs\backup_%%B_log_%stamp%.log" 2>&1
		
		cd !path!
		for /f "skip=10 eol=: delims=" %%C in ('dir /b /o-d /a-d *.ged') do ( 
			
			@del "%%C" 
		)
	)
	
)
	
	



