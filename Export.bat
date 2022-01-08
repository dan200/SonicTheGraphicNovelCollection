@echo off
setlocal EnableDelayedExpansion

echo ---------------------------------------------------
echo Sonic the Graphic Novel Collection - Export script
echo ---------------------------------------------------

SET CBZ=data\CBZTool\CBZTool.exe
SET ENHANCE_PARAMS=-whitebalance -denoise

:: Decide which folder to export from
if exist issues (
	:: An issues folder exists, ask the user if we they want to enhance it
	echo Issues folder found. Would you like to run image enhancement on the contents of these issues?
	echo This may take some time, but will greatly improve the image quality of the final volumes.

	choice /c YNC
	if ERRORLEVEL == 3 (
		:: Cancel
		echo ---------------------------------------------------
		pause
		exit /b
	) else if ERRORLEVEL == 2 (
		:: Export from the unenhanced issues folder
		echo ---------------------------------------------------
		echo Exporting from issues...
		SET ISSUE_DIR=issues
	) else (
		:: Enhance the images
		echo ---------------------------------------------------
		echo Enhancing...
		if not exist issues_enhanced (
			mkdir issues_enhanced
		)

		for %%a in ("issues\*.cbz") do (			
			set b=%%a
			if not exist "issues_enhanced\!b:~7,-4!.cbz" (
				if exist "issues_enhanced\!b:~7,-4!" (
					rmdir /s /q "issues_enhanced\!b:~7,-4!"
				)
				%CBZ% extract "%%a" %ENHANCE_PARAMS% -metadata -o "issues_enhanced\!b:~7,-4!"
				%CBZ% compress "issues_enhanced\!b:~7,-4!" -metadata
				rmdir /s /q "issues_enhanced\!b:~7,-4!"
			)
		)
		echo Finished

		:: Export from the enhanced issues folder
		echo ---------------------------------------------------
		echo Exporting from issues_enhanced...
		SET ISSUE_DIR=issues_enhanced
	)
) else (
	:: No issues folder exists, ask the user to create one
	echo Could not find a folder named issues.
	echo Please create one, place all your sonic the comic .cbz files inside, then re-run this script.

	echo ---------------------------------------------------
	pause
	exit /b
)

:: Start with an empty directory
if exist volumes (
	rmdir /s /q volumes
)
mkdir volumes

:: SONIC THE HEDGEHOG - VOLUME 1
:: -----------------------------

SET TITLE=Sonic the Hedgehog - Volume 1
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents2.png" -o "volumes\%TITLE%" -a

:: Sonic's World - Prologue: Once Upon a Planet...
%CBZ% extract "%ISSUE_DIR%\SonicTheComic025may1994.cbz" -p 19-23 -o "volumes\%TITLE%" -a

:: Sonic's World - Part 1 Kintobor spelled backwards is...
%CBZ% extract "%ISSUE_DIR%\SonicTheComic026may1994.cbz" -p 19-23 -o "volumes\%TITLE%" -a

:: Sonic's World - Part 2 A Tale of Tails
%CBZ% extract "%ISSUE_DIR%\SonicTheComic027jun1994.cbz" -p 19-23 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Enter: Sonic
%CBZ% extract "%ISSUE_DIR%\Sonic the Comic 001 (May 1993).cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Robofox
%CBZ% extract "%ISSUE_DIR%\SonicTheComic002jun1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Mayhem in the Marble Zone
%CBZ% extract "%ISSUE_DIR%\SonicTheComic003jun1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Day of the Badniks
%CBZ% extract "%ISSUE_DIR%\SonicTheComic004jul1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Lost in the Labyrinth Zone
%CBZ% extract "%ISSUE_DIR%\SonicTheComic005jul1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Attack On The Death Egg
%CBZ% extract "%ISSUE_DIR%\SonicTheComic006aug1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Super Sonic
%CBZ% extract "%ISSUE_DIR%\SonicTheComic007aug1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Origin of Sonic
%CBZ% extract "%ISSUE_DIR%\SonicTheComic008sep1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Back to Reality
%CBZ% extract "%ISSUE_DIR%\SonicTheComic009sep1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Megatox
%CBZ% extract "%ISSUE_DIR%\SonicTheComic010oct1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Time Racer
%CBZ% extract "%ISSUE_DIR%\SonicTheComic011oct1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Hidden Danger!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic012oct1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Double Trouble
%CBZ% extract "%ISSUE_DIR%\SonicTheComic013nov1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Hero of the Year
%CBZ% extract "%ISSUE_DIR%\SonicTheComic014nov1993.cbz" -p 3-6,9,7-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Green Eater
%CBZ% extract "%ISSUE_DIR%\SonicTheComic015dec1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Happy Christmas Doctor Robotnik
%CBZ% extract "%ISSUE_DIR%\SonicTheComic016dec1993.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Sonic the Human
%CBZ% extract "%ISSUE_DIR%\SonicTheComic017jan1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Casino Night
%CBZ% extract "%ISSUE_DIR%\SonicTheComic018feb1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic019feb1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Hill Top Terror
%CBZ% extract "%ISSUE_DIR%\SonicTheComic020mar1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Kid Cruel Caper
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 03 (1993).cbz" -p 2-7 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Girl Trouble
%CBZ% extract "%ISSUE_DIR%\SonicTheComic021mar1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic022apr1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Pirates of the Mystic Cave
%CBZ% extract "%ISSUE_DIR%\SonicTheComic023apr1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Sonic Terminator
%CBZ% extract "%ISSUE_DIR%\SonicTheComic024apr1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic025may1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic026may1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic027jun1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic028jun1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Sentinel
%CBZ% extract "%ISSUE_DIR%\SonicTheComic029jul1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Metamorphia
%CBZ% extract "%ISSUE_DIR%\SonicTheComic030jul1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Pretender
%CBZ% extract "%ISSUE_DIR%\SonicTheComic031aug1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Ocean of Horror
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 05 (1994).cbz" -p 2-7 -o "volumes\%TITLE%" -a

:: Bonus Content seperator
%CBZ% extract "data\%TITLE%\bonus_content.png" -o "volumes\%TITLE%" -a

:: Doctor Robotnik interview
%CBZ% extract "%ISSUE_DIR%\SonicTheSummerSpecial1994.cbz" -p 12-14 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\Sonic the Comic 001 (May 1993).cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic002jun1993.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic003jun1993.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic006aug1993.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic008sep1993.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic011oct1993.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic014nov1993.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic015dec1993.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic016dec1993.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic017jan1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic022apr1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic023apr1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic026may1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic027jun1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 01 (1993).cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 02 (1993).cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 03 (1993).cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 05 (1994).cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: SONIC THE HEDGEHOG - VOLUME 2
:: -----------------------------

SET TITLE=Sonic the Hedgehog - Volume 2
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents2.png" -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Doctor Sun
%CBZ% extract "%ISSUE_DIR%\SonicTheSummerSpecial1994.cbz" -p 3-8,41-46 -o "volumes\%TITLE%" -a

:: Doctor Robotnik - Test Drive
%CBZ% extract "%ISSUE_DIR%\SonicTheSummerSpecial1994.cbz" -p 15-18 -o "volumes\%TITLE%" -a

:: Sonic's World - No More Mr. Nice Bug
%CBZ% extract "%ISSUE_DIR%\SonicTheComic032aug1994.cbz" -p 19-22 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic033sep1994.cbz" -p 19-22 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic034sep1994.cbz" -p 20-23 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Sonic No More
%CBZ% extract "%ISSUE_DIR%\SonicTheComic039nov1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Unbeatable Foe
%CBZ% extract "%ISSUE_DIR%\SonicTheComic032aug1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Knuckles - Guardian of the Chaos Emeralds
%CBZ% extract "%ISSUE_DIR%\SonicTheSummerSpecial1994.cbz" -p 31-34 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Enter Knuckles
%CBZ% extract "%ISSUE_DIR%\SonicTheComic033sep1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic034sep1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Marble Garden Menace
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 06 (1994).cbz" -p 2-7 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Power of the Chaos Emeralds
%CBZ% extract "%ISSUE_DIR%\SonicTheComic035sep1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic036oct1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Robotnik's Revenge
%CBZ% extract "%ISSUE_DIR%\SonicTheComic037oct1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic038nov1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Frozen Zone
%CBZ% extract "%ISSUE_DIR%\SonicTheComic040dec1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Knuckles - Carnival Night Conspiracy
%CBZ% extract "%ISSUE_DIR%\SonicTheComic039nov1994.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic040dec1994.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic041dec1994.cbz" -p 23-27 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic042jan1995.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic043jan1995.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic044feb1995.cbz" -p 20-24 -o "volumes\%TITLE%" -a

:: Sonic and Knuckles in The Chaos Emerald Thief
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 08 (1994).cbz" -p 2-7 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Ice Cap Attack
%CBZ% extract "%ISSUE_DIR%\SonicTheComic041dec1994.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic042jan1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Doctor Robotnik - A Day in the Life of Robotnik
%CBZ% extract "%ISSUE_DIR%\SonicTheComic042jan1995.cbz" -p 31-36 -o "volumes\%TITLE%" -a

:: Sonic and Tails - Trapped in the Vortex
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 09 (1994).cbz" -p 2-7 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Badniks Bridge
%CBZ% extract "%ISSUE_DIR%\SonicTheComic043jan1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic044feb1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Day of The Death Egg
%CBZ% extract "%ISSUE_DIR%\SonicTheComic045feb1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic's World - Enter the Cybernik
%CBZ% extract "%ISSUE_DIR%\SonicTheComic045feb1995.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic046mar1995.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic047mar1995.cbz" -p 19-23 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Big Con
%CBZ% extract "%ISSUE_DIR%\SonicTheComic046mar1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Captain Plunder - Captain Plunder & His Sky Pirates!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic047mar1995.cbz" -p 26-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic048mar1995.cbz" -p 27-31 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic049apr1995.cbz" -p 26-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic050apr1995.cbz" -p 26-30 -o "volumes\%TITLE%" -a

:: Knuckles Versus The Cybernik
%CBZ% extract "%ISSUE_DIR%\SonicTheComic052may1995.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Sonic's World - Face From The Past
%CBZ% extract "%ISSUE_DIR%\SonicTheComic051may1995.cbz" -p 26-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic052may1995.cbz" -p 24-28 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Mystery of the Sandopolis Zone
%CBZ% extract "%ISSUE_DIR%\SonicTheComic047mar1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic048mar1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Count Down to Disaster
%CBZ% extract "%ISSUE_DIR%\SonicTheComic049apr1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic050apr1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Disaster!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic051may1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic052may1995.cbz" -p 3-8 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic053jun1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic032aug1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic033sep1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic035sep1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic037oct1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic038nov1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic040dec1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic041dec1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic042jan1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic045feb1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic046mar1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic050apr1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic052may1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic053jun1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 06 (1994).cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 08 (1994).cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 09 (1994).cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheSummerSpecial1994.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: SONIC THE HEDGEHOG - VOLUME 3
:: -----------------------------

SET TITLE=Sonic the Hedgehog - Volume 3
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Holiday Hot Spot
%CBZ% extract "%ISSUE_DIR%\SonicHolidaySpecial1995.cbz" -p 3-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Beware Predicto!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic054jun1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Great Escape
%CBZ% extract "%ISSUE_DIR%\SonicTheComic055jul1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic056jul1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Knuckles - Total Chaotix
%CBZ% extract "%ISSUE_DIR%\SonicTheComic053jun1995.cbz" -p 18-22 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic054jun1995.cbz" -p 18-22 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic055jul1995.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic056jul1995.cbz" -p 18-22 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic057aug1995.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic058aug1995.cbz" -p 18-22 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Rampage of Mekanik
%CBZ% extract "%ISSUE_DIR%\SonicTheComic057aug1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic058aug1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic's World - The Seven Badniks
%CBZ% extract "%ISSUE_DIR%\SonicTheComic059sep1995.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic060sep1995.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic061sep1995.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic062oct1995.cbz" -p 26-29 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Brotherhood of Metallix
%CBZ% extract "%ISSUE_DIR%\SonicTheComic059sep1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic060sep1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic061sep1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic062oct1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Project Brutus
%CBZ% extract "%ISSUE_DIR%\SonicTheComic063oct1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic064nov1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic065nov1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic066dec1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic's World - Cybernik Strikes Back
%CBZ% extract "%ISSUE_DIR%\SonicTheComic063oct1995.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic064nov1995.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic065nov1995.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic066dec1995.cbz" -p 25-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic067dec1995.cbz" -p 24-28 -o "volumes\%TITLE%" -a

:: Knuckles - The Homecoming
%CBZ% extract "%ISSUE_DIR%\SonicTheComic065nov1995.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic066dec1995.cbz" -p 18-22 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic067dec1995.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic068jan1996.cbz" -p 18-22 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Return of Chaotix
%CBZ% extract "%ISSUE_DIR%\SonicTheComic067dec1995.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic068jan1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic069jan1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic070feb1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic071feb1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic072mar1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Knuckles - The Graveyard
%CBZ% extract "%ISSUE_DIR%\SonicTheComic069jan1996.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic070feb1996.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic071feb1996.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic072mar1996.cbz" -p 13-17 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog (Extra Story) - Odour Zone
%CBZ% extract "%ISSUE_DIR%\SonicTheComic072mar1996.cbz" -p 18-23 -o "volumes\%TITLE%" -a

:: Sonic's World - Brute Force
%CBZ% extract "%ISSUE_DIR%\SonicTheComic069jan1996.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic070feb1996.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic071feb1996.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic072mar1996.cbz" -p 26-30 -o "volumes\%TITLE%" -a

:: Bonus Content seperator
%CBZ% extract "data\%TITLE%\bonus_content.png" -o "volumes\%TITLE%" -a

:: Sonic interview
%CBZ% extract "%ISSUE_DIR%\SonicHolidaySpecial1996.cbz" -p 14-16 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover Gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic054jun1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic056jul1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic057aug1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic058aug1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic060sep1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic061sep1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic063oct1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic064nov1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic065nov1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic067dec1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic069jan1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic070feb1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic071feb1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic072mar1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicHolidaySpecial1995.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: SONIC THE HEDGEHOG - VOLUME 4
:: -----------------------------

SET TITLE=Sonic the Hedgehog - Volume 4
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents2.png" -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Spinball Wizard
%CBZ% extract "%ISSUE_DIR%\SonicTheComic073mar1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Knuckles - New Master Emerald
%CBZ% extract "%ISSUE_DIR%\SonicTheComic073mar1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Mission to the Metropolis Zone
%CBZ% extract "%ISSUE_DIR%\SonicTheComic074mar1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Smokey and the Badnik
%CBZ% extract "%ISSUE_DIR%\SonicTheComic075apr1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Big Decision
%CBZ% extract "%ISSUE_DIR%\SonicTheComic076apr1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Knuckles - Traitor of the Lost Pyramid
%CBZ% extract "%ISSUE_DIR%\KnucklesKnock-outSpecial1996.cbz" -p 4-9,16-21 -o "volumes\%TITLE%" -a

:: Knuckles - Jakes Story
%CBZ% extract "%ISSUE_DIR%\KnucklesKnock-outSpecial1996.cbz" -p 27-32 -o "volumes\%TITLE%" -a

:: Knuckles - Reflections
%CBZ% extract "%ISSUE_DIR%\KnucklesKnock-outSpecial1996.cbz" -p 37-42 -o "volumes\%TITLE%" -a

:: Knuckles - The Ghost Ship
%CBZ% extract "%ISSUE_DIR%\SonicTheComic074mar1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic075apr1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic076apr1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic077may1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic078may1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic079jun1996.cbz" -p 11-15 -o "volumes\%TITLE%" -a

:: Sonic's World - Hidden Danger
%CBZ% extract "%ISSUE_DIR%\SonicTheComic077may1996.cbz" -p 22-26 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic078may1996.cbz" -p 26-30 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Voice of the People
%CBZ% extract "%ISSUE_DIR%\SonicTheComic077may1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Plasma
%CBZ% extract "%ISSUE_DIR%\SonicTheComic078may1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Return to the Miracle Planet
%CBZ% extract "%ISSUE_DIR%\SonicTheComic079jun1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic's World - Revolution
%CBZ% extract "%ISSUE_DIR%\SonicTheComic079jun1996.cbz" -p 25-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic080jun1996.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic081jul1996.cbz" -p 26-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic082jul1996.cbz" -p 26-30 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Break Out
%CBZ% extract "%ISSUE_DIR%\SonicHolidaySpecial1996.cbz" -p 4-9,17-22 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Sonic vs Shortfuse
%CBZ% extract "%ISSUE_DIR%\SonicHolidaySpecial1996.cbz" -p 26-31 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Movie Madness
%CBZ% extract "%ISSUE_DIR%\SonicHolidaySpecial1996.cbz" -p 38-43 -o "volumes\%TITLE%" -a

:: Chaotix Crew - The Fundamental Four
%CBZ% extract "%ISSUE_DIR%\SonicTheComic080jun1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic081jul1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Knuckles - Troubled Waters
%CBZ% extract "%ISSUE_DIR%\SonicTheComic082jul1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic083aug1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Running Wild
%CBZ% extract "%ISSUE_DIR%\SonicTheComic080jun1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic081jul1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic082jul1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Bubble Trouble
%CBZ% extract "%ISSUE_DIR%\SonicTheComic083aug1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic's World - New Image
%CBZ% extract "%ISSUE_DIR%\SonicTheComic084aug1996.cbz" -p 26-30 -o "volumes\%TITLE%" -a

:: Sonic's World - Future Shock
%CBZ% extract "%ISSUE_DIR%\SonicTheComic086sep1996.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic087oct1996.cbz" -p 26-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic088oct1996.cbz" -p 27-31 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Heroes & Villians
%CBZ% extract "%ISSUE_DIR%\SonicTheComic084aug1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic085aug1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic086sep1996.cbz" -p 3-8 -o "volumes\%TITLE%" -a

:: Knuckles - Village of the Damned
%CBZ% extract "%ISSUE_DIR%\SonicTheComic084aug1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic085aug1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic086sep1996.cbz" -p 11-15 -o "volumes\%TITLE%" -a

:: Sonic's World - Scream Theme Park
%CBZ% extract "%ISSUE_DIR%\SonicTheComic085aug1996.cbz" -p 26-30 -o "volumes\%TITLE%" -a

:: Bonus Content seperator
%CBZ% extract "data\%TITLE%\bonus_content.png" -o "volumes\%TITLE%" -a

:: Knuckles interview
%CBZ% extract "%ISSUE_DIR%\KnucklesKnock-outSpecial1996.cbz" -p 24-26 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic074mar1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic075apr1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic076apr1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic077may1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic078may1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic079jun1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic080jun1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic081jul1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic082jul1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic083aug1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic084aug1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic085aug1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic086sep1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicHolidaySpecial1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\KnucklesKnock-outSpecial1996.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: SONIC THE HEDGEHOG - VOLUME 5
:: -----------------------------

SET TITLE=Sonic the Hedgehog - Volume 5
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents2.png" -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Mister Shifter
%CBZ% extract "%ISSUE_DIR%\SonicTheComic087oct1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Knuckles - The Good, The Bad and the Echidna
%CBZ% extract "%ISSUE_DIR%\SonicTheComic087oct1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic088oct1996.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic089oct1996.cbz" -p 11-15 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic090nov1996.cbz" -p 11-15 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Ultimate Nightmare
%CBZ% extract "%ISSUE_DIR%\SonicTheComic088oct1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Tomb
%CBZ% extract "%ISSUE_DIR%\SonicTheComic089oct1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic090nov1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic's World - A New Hope
%CBZ% extract "%ISSUE_DIR%\SonicTheComic089oct1996.cbz" -p 25-29 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Hive
%CBZ% extract "%ISSUE_DIR%\SonicTheComic091nov1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic092dec1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic's World - Secret Weapon
%CBZ% extract "%ISSUE_DIR%\SonicTheComic090nov1996.cbz" -p 23-27 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic091nov1996.cbz" -p 24-28 -o "volumes\%TITLE%" -a

:: Captain Plunder - Shanghaied
%CBZ% extract "%ISSUE_DIR%\SonicTheComic091nov1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic092dec1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic093dec1996.cbz" -p 11-15 -o "volumes\%TITLE%" -a

:: Sonic's World - Head in the Clouds
%CBZ% extract "%ISSUE_DIR%\SonicTheComic092dec1996.cbz" -p 24-28 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - A Christmas Wish
%CBZ% extract "%ISSUE_DIR%\SonicTheComic093dec1996.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic's World - Season of Goodwill
%CBZ% extract "%ISSUE_DIR%\SonicTheComic093dec1996.cbz" -p 25-29 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Eve of Destruction
%CBZ% extract "%ISSUE_DIR%\SonicTheComic094jan1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Knuckles - Roots
%CBZ% extract "%ISSUE_DIR%\SonicTheComic094jan1997.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic095jan1997.cbz" -p 11-15 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic096feb1997.cbz" -p 11-15 -o "volumes\%TITLE%" -a

:: Sonic's World - The Monster Wakes
%CBZ% extract "%ISSUE_DIR%\SonicTheComic094jan1997.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic095jan1997.cbz" -p 22-26 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Big Fight
%CBZ% extract "%ISSUE_DIR%\SonicTheComic095jan1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Hero Hour
%CBZ% extract "%ISSUE_DIR%\SonicTheComic096feb1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic's World - Mock the Doc
%CBZ% extract "%ISSUE_DIR%\SonicTheComic096feb1997.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Sonic's World - Boiling Point
%CBZ% extract "%ISSUE_DIR%\SonicTheComic097feb1997.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Doomsday
%CBZ% extract "%ISSUE_DIR%\SonicTheComic097feb1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic098mar1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic099mar1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Knuckles - Victims
%CBZ% extract "%ISSUE_DIR%\SonicTheComic097feb1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic098mar1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic099mar1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Sonic's World - Solidarity
%CBZ% extract "%ISSUE_DIR%\SonicTheComic098mar1997.cbz" -p 22-26 -o "volumes\%TITLE%" -a

:: Sonic's World - No Exit
%CBZ% extract "%ISSUE_DIR%\SonicTheComic099mar1997.cbz" -p 22-26 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Final Victory
%CBZ% extract "%ISSUE_DIR%\SonicTheComic100apr1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Knuckles - The Final Victory
%CBZ% extract "%ISSUE_DIR%\SonicTheComic100apr1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Doctor Robotnik - The Final Victory
%CBZ% extract "%ISSUE_DIR%\SonicTheComic100apr1997.cbz" -p 15-19 -o "volumes\%TITLE%" -a

:: Sonic's World - The Final Victory
%CBZ% extract "%ISSUE_DIR%\SonicTheComic100apr1997.cbz" -p 22-26 -o "volumes\%TITLE%" -a

:: Bonus Content seperator
%CBZ% extract "data\%TITLE%\bonus_content.png" -o "volumes\%TITLE%" -a

:: Cybernik profile
%CBZ% extract "%ISSUE_DIR%\SonicHolidaySpecial1996.cbz" -p 32 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic087oct1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic088oct1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic089oct1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic090nov1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic091nov1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic092dec1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic093dec1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic094jan1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic095jan1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic096feb1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic097feb1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic098mar1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic099mar1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic100apr1997.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: SONIC THE HEDGEHOG - VOLUME 6
:: -----------------------------

SET TITLE=Sonic the Hedgehog - Volume 6
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents2.png" -o "volumes\%TITLE%" -a

:: Knuckles - Loose Ends
%CBZ% extract "%ISSUE_DIR%\SonicTheComic101apr1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Vote For Me
%CBZ% extract "%ISSUE_DIR%\SonicTheComic101apr1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic's World - Invasion of the Veg Heads
%CBZ% extract "%ISSUE_DIR%\SonicTheComic101apr1997.cbz" -p 21-25 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic102apr1997.cbz" -p 22-26 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Unnatural Disasters
%CBZ% extract "%ISSUE_DIR%\SonicTheComic102apr1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: What Ever Happened to Super Sonic?
%CBZ% extract "%ISSUE_DIR%\SonicTheComic102apr1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - DIY Danger
%CBZ% extract "%ISSUE_DIR%\SonicTheComic103may1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic's World - Crawling from the Wreckage
%CBZ% extract "%ISSUE_DIR%\SonicTheComic103may1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Captain Plunder and the Spice Maidens
%CBZ% extract "%ISSUE_DIR%\SonicTheComic103may1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic104may1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic105jun1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic106jun1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic107jul1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic108jul1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Flickies' Island
%CBZ% extract "%ISSUE_DIR%\SonicTheComic104may1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic105jun1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic106jun1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Double Sonic - Zero Zone
%CBZ% extract "%ISSUE_DIR%\SonicTheComic106jun1997.cbz" -p 23-27 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic107jul1997.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Bravehog
%CBZ% extract "%ISSUE_DIR%\SonicTheComic107jul1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Evil Empire
%CBZ% extract "%ISSUE_DIR%\SonicTheComic108jul1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic109aug1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic110aug1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic111sep1997.cbz" -p 3-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - No Future
%CBZ% extract "%ISSUE_DIR%\SonicTheComic112sep1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Double Sonic - Raining Bananas
%CBZ% extract "%ISSUE_DIR%\SonicTheComic112sep1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Detour
%CBZ% extract "%ISSUE_DIR%\SonicTheComic113sep1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Crisis in the Chemical Plant Zone
%CBZ% extract "%ISSUE_DIR%\SonicTheComic114oct1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic115oct1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Best of Enemies
%CBZ% extract "%ISSUE_DIR%\SonicTheComic116nov1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic117nov1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic118dec1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Double Sonic - Hot Legs
%CBZ% extract "%ISSUE_DIR%\SonicTheComic117nov1997.cbz" -p 22-26 -o "volumes\%TITLE%" -a

:: Super Sonic - Hunter & The Hunted
%CBZ% extract "%ISSUE_DIR%\SonicTheComic116nov1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic117nov1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic118dec1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Double Sonic - Face to Face
%CBZ% extract "%ISSUE_DIR%\SonicTheComic118dec1997.cbz" -p 28-34 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Black Christmas
%CBZ% extract "%ISSUE_DIR%\SonicTheComic119dec1997.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Riot Resolution
%CBZ% extract "%ISSUE_DIR%\SonicTheComic120jan1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Bonus Content seperator
%CBZ% extract "data\%TITLE%\bonus_content.png" -o "volumes\%TITLE%" -a

:: How To Draw Sonic
%CBZ% extract "%ISSUE_DIR%\SonicHolidaySpecial1996.cbz" -p 33-36 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic101apr1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic102apr1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic103may1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic104may1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic105jun1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic106jun1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic107jul1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic108jul1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic109aug1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic110aug1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic111sep1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic112sep1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic113sep1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic114oct1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic115oct1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic116nov1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic117nov1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic118dec1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic119dec1997.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic120jan1998.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: TAILS - VOLUME 1
:: ----------------

SET TITLE=Tails - Volume 1
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents2.png" -o "volumes\%TITLE%" -a

:: Tails - The Nameless Zone
%CBZ% extract "%ISSUE_DIR%\SonicTheComic016dec1993.cbz" -p 25-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic017jan1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a

:: Tails - The Land Beyond
%CBZ% extract "%ISSUE_DIR%\SonicTheComic018feb1994.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic019feb1994.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic020mar1994.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic021mar1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a

:: Tails - The Morbidden Hunt
%CBZ% extract "%ISSUE_DIR%\SonicTheComic028jun1994.cbz" -p 19-22 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic029jul1994.cbz" -p 19-22 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic030jul1994.cbz" -p 21-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic031aug1994.cbz" -p 19-22 -o "volumes\%TITLE%" -a

:: Tails - Attack of the Badniks
%CBZ% extract "%ISSUE_DIR%\SonicTheSummerSpecial1994.cbz" -p 21-24 -o "volumes\%TITLE%" -a

:: Tails - Zonerunner & The Flock
%CBZ% extract "%ISSUE_DIR%\SonicTheComic035sep1994.cbz" -p 19-22 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic036oct1994.cbz" -p 19-22 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic037oct1994.cbz" -p 19-22 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic038nov1994.cbz" -p 20-23 -o "volumes\%TITLE%" -a

:: Tails - Hero of Mobius
%CBZ% extract "%ISSUE_DIR%\SonicTheComic042jan1995.cbz" -p 19-22 -o "volumes\%TITLE%" -a

:: Tails in Zonerunner & The Big Freeze
%CBZ% extract "%ISSUE_DIR%\SonicTheComic048mar1995.cbz" -p 21-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic049apr1995.cbz" -p 20-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic050apr1995.cbz" -p 20-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic051may1995.cbz" -p 20-23 -o "volumes\%TITLE%" -a

:: Knuckles and Tails - The Revenge of Trogg
%CBZ% extract "%ISSUE_DIR%\SonicTheComic059sep1995.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic060sep1995.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic061sep1995.cbz" -p 18-22 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic062oct1995.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic063oct1995.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic064nov1995.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Tails - Fox On The Run
%CBZ% extract "%ISSUE_DIR%\SonicTheComic073mar1996.cbz" -p 26-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic074mar1996.cbz" -p 26-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic075apr1996.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic076apr1996.cbz" -p 22-26 -o "volumes\%TITLE%" -a

:: Tails - Grounded
%CBZ% extract "%ISSUE_DIR%\SonicTheComic079jun1996.cbz" -p 18-22 -o "volumes\%TITLE%" -a

:: Tails - Fleabyte Returns
%CBZ% extract "%ISSUE_DIR%\SonicTheComic080jun1996.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Tails - Shock Tactics!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic081jul1996.cbz" -p 19-23 -o "volumes\%TITLE%" -a

:: Tails - Changing Times
%CBZ% extract "%ISSUE_DIR%\SonicTheComic082jul1996.cbz" -p 19-23 -o "volumes\%TITLE%" -a

:: Tails - Mystery Villain
%CBZ% extract "%ISSUE_DIR%\SonicTheComic083aug1996.cbz" -p 19-23 -o "volumes\%TITLE%" -a

:: Tails - Sneaker Seeker
%CBZ% extract "%ISSUE_DIR%\SonicTheComic084aug1996.cbz" -p 19-23 -o "volumes\%TITLE%" -a

:: Tails - Trooper Trouble
%CBZ% extract "%ISSUE_DIR%\SonicTheComic085aug1996.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic086sep1996.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Tails - Easy Target
%CBZ% extract "%ISSUE_DIR%\SonicTheComic087oct1996.cbz" -p 19-23 -o "volumes\%TITLE%" -a

:: Tails - Small Change
%CBZ% extract "%ISSUE_DIR%\SonicTheComic088oct1996.cbz" -p 20-24 -o "volumes\%TITLE%" -a

:: Tails - Furtual Reality
%CBZ% extract "%ISSUE_DIR%\SonicTheComic096feb1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Tails - Flip Side
%CBZ% extract "%ISSUE_DIR%\SonicTheComic103may1997.cbz" -p 22-26 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic104may1997.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Tails - Kog the Mighty
%CBZ% extract "%ISSUE_DIR%\SonicTheComic109aug1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Tails - The Unbrushables
%CBZ% extract "%ISSUE_DIR%\SonicTheComic110aug1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic018feb1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic029jul1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic036oct1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic048mar1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic059sep1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic062oct1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic073mar1996.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic047mar1995.cbz" -p 33 -o "volumes\%TITLE%" -a

:: Back cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: GOLDEN AXE
:: ----------

SET TITLE=Golden Axe
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Golden Axe - Citadel of Dead Souls
%CBZ% extract "%ISSUE_DIR%\Sonic the Comic 001 (May 1993).cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic002jun1993.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic003jun1993.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic004jul1993.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic005jul1993.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic006aug1993.cbz" -p 20-24 -o "volumes\%TITLE%" -a

:: Golden Axe - Plague of Serpents
%CBZ% extract "%ISSUE_DIR%\SonicTheComic013nov1993.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic014nov1993.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic015dec1993.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic016dec1993.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic017jan1994.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic018feb1994.cbz" -p 20-24 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic005jul1993.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: STREETS OF RAGE
:: ---------------

SET TITLE=Streets of Rage
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Streets of Rage
%CBZ% extract "%ISSUE_DIR%\SonicTheComic007aug1993.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic008sep1993.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic009sep1993.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic010oct1993.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic011oct1993.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic012oct1993.cbz" -p 20-24 -o "volumes\%TITLE%" -a

:: Streets of Rage - Skates' Story
%CBZ% extract "%ISSUE_DIR%\SonicTheComic025may1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic026may1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic027jun1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic028jun1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic029jul1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic030jul1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Streets of Rage - Facts of Life
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 07 (1994).cbz" -p 2-7 -o "volumes\%TITLE%" -a

:: Streets of Rage - The Only Game in Town
%CBZ% extract "%ISSUE_DIR%\SonicTheComic041dec1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic042jan1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic043jan1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic044feb1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic045feb1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic046mar1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Bonus Content seperator
%CBZ% extract "data\%TITLE%\bonus_content.png" -o "volumes\%TITLE%" -a

:: Streets of Rage Battle Wagon
%CBZ% extract "%ISSUE_DIR%\SonicTheComic041dec1994.cbz" -p 22 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Covers
%CBZ% extract "%ISSUE_DIR%\SonicTheComic007aug1993.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic025may1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic030jul1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic043jan1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 07 (1994).cbz" -p 1 -o "volumes\%TITLE%" -a

:: Previews
%CBZ% extract "%ISSUE_DIR%\Sonic the Comic 001 (May 1993).cbz" -p 27 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic023apr1994.cbz" -p 33 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: ECCO THE DOLPHIN
:: ----------------

SET TITLE=Ecco the Dolphin
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Ecco the Dolphin
%CBZ% extract "%ISSUE_DIR%\SonicTheComic013nov1993.cbz" -p 11-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic014nov1993.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic015dec1993.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic016dec1993.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic017jan1994.cbz" -p 13-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic018feb1994.cbz" -p 13-17 -o "volumes\%TITLE%" -a

:: Return of Ecco the Dolphin
%CBZ% extract "%ISSUE_DIR%\SonicTheComic060sep1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic061sep1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic062oct1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic063oct1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic064nov1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic065nov1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic013nov1993.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: -------------

:: Compress all folders to .cbz files
%CBZ% compress "volumes\*" -metadata

:: Delete the loose images
echo Deleting loose directories...
for /d %%a in ("volumes\*") do rmdir /s /q "%%a"

echo Finished.
echo ---------------------------------------------------
pause
