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
	echo Issues folder found. Would you like to run denoise and white-balance these issues?
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

:: SONIC THE HEDGEHOG - VOLUME 7
:: -----------------------------

SET TITLE=Sonic the Hedgehog - Volume 7
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents2.png" -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Hobson & Choy
%CBZ% extract "%ISSUE_DIR%\SonicTheComic121jan1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic122feb1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Double Sonic - Bee Prepared
%CBZ% extract "%ISSUE_DIR%\SonicTheComic121jan1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Knuckles - On the Run
%CBZ% extract "%ISSUE_DIR%\SonicTheComic121jan1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic122feb1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic123feb1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic124feb1998.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Double Sonic - Root of All Evil
%CBZ% extract "%ISSUE_DIR%\SonicTheComic122feb1998.cbz" -p 23-27 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic123feb1998.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Order & Chaos
%CBZ% extract "%ISSUE_DIR%\SonicTheComic123feb1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic124feb1998.cbz" -p 3-8 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic125mar1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Double Sonic - Fan Friction
%CBZ% extract "%ISSUE_DIR%\SonicTheComic124feb1998.cbz" -p 22-26 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The House on the Hill
%CBZ% extract "%ISSUE_DIR%\SonicTheComic126mar1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Double Sonic - Taking the Plunge
%CBZ% extract "%ISSUE_DIR%\SonicTheComic126mar1998.cbz" -p 23-27 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic127apr1998.cbz" -p 22-26 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Robotnik Reigns Supreme (Parts 1-2)
%CBZ% extract "%ISSUE_DIR%\SonicTheComic127apr1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic128apr1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Double Sonic - Show of Strength
%CBZ% extract "%ISSUE_DIR%\SonicTheComic128apr1998.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Robotnik Reigns Supreme (Part 3)
%CBZ% extract "%ISSUE_DIR%\SonicTheComic129may1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Showdown
%CBZ% extract "%ISSUE_DIR%\SonicTheComic130may1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic130may1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic130may1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Shady Characters
%CBZ% extract "%ISSUE_DIR%\SonicTheComic131jun1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic132jun1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Double Sonic - Game On!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic131jun1998.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Sun Trap
%CBZ% extract "%ISSUE_DIR%\SonicTheComic133jul1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Double Sonic - Football Lazy
%CBZ% extract "%ISSUE_DIR%\SonicTheComic133jul1998.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Double Sonic - Hyper Sonic
%CBZ% extract "%ISSUE_DIR%\SonicTheComic134jul1998.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Back In The Special Zone
%CBZ% extract "%ISSUE_DIR%\SonicTheComic134jul1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Roots
%CBZ% extract "%ISSUE_DIR%\SonicTheComic135jul1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic136aug1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic137aug1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic138sep1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Knuckles - The Take-Over
%CBZ% extract "%ISSUE_DIR%\SonicTheComic135jul1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic136aug1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic137aug1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic138sep1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Whatever Happened to Grimer?
%CBZ% extract "%ISSUE_DIR%\SonicTheComic139sep1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Bonus Content seperator
%CBZ% extract "data\%TITLE%\bonus_content.png" -o "volumes\%TITLE%" -a

:: Megadroid
%CBZ% extract "%ISSUE_DIR%\SonicTheComic041dec1994.cbz" -p 18-21 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic121jan1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic122feb1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic123feb1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic124feb1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic125mar1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic126mar1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic127apr1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic128apr1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic129may1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic130may1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic131jun1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic132jun1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic133jul1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic134jul1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic135jul1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic136aug1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic137aug1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic138sep1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic139sep1998.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: SONIC THE HEDGEHOG - VOLUME 8
:: -----------------------------

SET TITLE=Sonic the Hedgehog - Volume 8
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents2.png" -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Forgotten Badnik
%CBZ% extract "%ISSUE_DIR%\SonicTheComic140oct1998.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Haunted Zone
%CBZ% extract "%ISSUE_DIR%\SonicTheComic141oct1998.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Revenge
%CBZ% extract "%ISSUE_DIR%\SonicTheComic142nov1998.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Secret Enemy
%CBZ% extract "%ISSUE_DIR%\SonicTheComic143nov1998.cbz" -p 2-8 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic144dec1998.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Child's Play
%CBZ% extract "%ISSUE_DIR%\SonicTheComic145dec1998.cbz" -p 2-4 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic145dec1998.cbz" -p 5 -o "volumes\%TITLE%" -a -rot180
%CBZ% extract "%ISSUE_DIR%\SonicTheComic145dec1998.cbz" -p 6-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Earth Attacks
%CBZ% extract "%ISSUE_DIR%\SonicTheComic146dec1998.cbz" -p 2-8 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic147jan1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Super Sonic - Return of the Nightmare
%CBZ% extract "%ISSUE_DIR%\SonicTheComic146dec1998.cbz" -p 15-19 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic147jan1999.cbz" -p 15-19 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic148jan1999.cbz" -p 15-19 -o "volumes\%TITLE%" -a

:: Sonic & Tekno - The Trickster
%CBZ% extract "%ISSUE_DIR%\SonicTheComic150feb1999.cbz" -p 9-13 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic151mar1999.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - It's A Small World
%CBZ% extract "%ISSUE_DIR%\SonicTheComic148jan1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Shanazar
%CBZ% extract "%ISSUE_DIR%\SonicTheComic149feb1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Robotnik No More?
%CBZ% extract "%ISSUE_DIR%\SonicTheComic150feb1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Mystic Mountain
%CBZ% extract "%ISSUE_DIR%\SonicTheComic151mar1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Mountain of Doom
%CBZ% extract "%ISSUE_DIR%\SonicTheComic152mar1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Heart of Evil
%CBZ% extract "%ISSUE_DIR%\SonicTheComic153apr1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Desert Storm
%CBZ% extract "%ISSUE_DIR%\SonicTheComic154apr1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Chaotix Crew - Crimson Cobra Strikes
%CBZ% extract "%ISSUE_DIR%\SonicTheComic152mar1999.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic153apr1999.cbz" -p 16-20 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic154apr1999.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Secret of the Tower
%CBZ% extract "%ISSUE_DIR%\SonicTheComic155may1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - No Escape
%CBZ% extract "%ISSUE_DIR%\SonicTheComic156may1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic157jun1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Bottled Up!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic158jun1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Rig
%CBZ% extract "%ISSUE_DIR%\SonicTheComic159jun1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Knightmares
%CBZ% extract "%ISSUE_DIR%\SonicTheComic160jul1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Space Race
%CBZ% extract "%ISSUE_DIR%\SonicTheComic161jul1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic162aug1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Medusa
%CBZ% extract "%ISSUE_DIR%\SonicTheComic163aug1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Worlds Collide
%CBZ% extract "%ISSUE_DIR%\SonicTheComic164sep1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic165sep1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Bonus Content seperator
%CBZ% extract "data\%TITLE%\bonus_content.png" -o "volumes\%TITLE%" -a

:: Megadroid - Megadroid On The Move
%CBZ% extract "%ISSUE_DIR%\SonicTheComic083aug1996.cbz" -p 26-30 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic140oct1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic141oct1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic142nov1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic143nov1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic144dec1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic145dec1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic146dec1998.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic147jan1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic148jan1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic149feb1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic150feb1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic151mar1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic152mar1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic153apr1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic154apr1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic155may1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic156may1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic157jun1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic158jun1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic159jun1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic160jul1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic161jul1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic162aug1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic163aug1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic164sep1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic165sep1999.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: SONIC THE HEDGEHOG - VOLUME 9
:: -----------------------------

SET TITLE=Sonic the Hedgehog - Volume 9
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents2.png" -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Earth Spirits
%CBZ% extract "%ISSUE_DIR%\SonicTheComic166oct1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Super Zone
%CBZ% extract "%ISSUE_DIR%\SonicTheComic167oct1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Mirror Image
%CBZ% extract "%ISSUE_DIR%\SonicTheComic168nov1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Secret of the Gods
%CBZ% extract "%ISSUE_DIR%\SonicTheComic169nov1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Splitzoid
%CBZ% extract "%ISSUE_DIR%\SonicTheComic170dec1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Planet in Peril!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic171dec1999.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Terra Connection
%CBZ% extract "%ISSUE_DIR%\SonicTheComic172jan2000.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Game Over
%CBZ% extract "%ISSUE_DIR%\SonicTheComic173jan2000.cbz" -p 2-8 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic174feb2000.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Coming of Chaos!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic175feb2000.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - What Price Victory?
%CBZ% extract "%ISSUE_DIR%\SonicTheComic176mar2000.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Night Terrors!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic177mar2000.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Splash-Down!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic178apr2000.cbz" -p 2-7 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Out of Time!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic179apr2000.cbz" -p 2-8 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Prisoner of War!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic180may2000.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - The Origin of Chaos!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic181may2000.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - War of the Worlds!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic182may2000.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Perfect Chaos!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic183jun2000.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Point of No Return!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic184jun2000.cbz" -p 3-9 -o "volumes\%TITLE%" -a

:: Seperator
%CBZ% extract "data\%TITLE%\later.png" -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - In Memory
%CBZ% extract "data\%TITLE%\261-101.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\261-102.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\261-103.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\261-104.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\261-105.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\261-106.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\261-107.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\261-108.jpg" -o "volumes\%TITLE%" -a

:: Sonic the Hedgehog - Exit: Sonic
%CBZ% extract "data\%TITLE%\275-201.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-202.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-203.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-204.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-205.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-206.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-207.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-208.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-209.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-210.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-211.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-212.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-213.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-214.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-215.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-216.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-217.jpg" -o "volumes\%TITLE%" -a

:: Bonus Content seperator
%CBZ% extract "data\%TITLE%\bonus_content.png" -o "volumes\%TITLE%" -a

:: Nigel Kitching interview
%CBZ% extract "%ISSUE_DIR%\SonicTheComic223dec2001Reprint-NewContentOnly.cbz" -p 2-3 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic166oct1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic167oct1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic168nov1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic169nov1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic170dec1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic171dec1999.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic172jan2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic173jan2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic174feb2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic175feb2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic176mar2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic177mar2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic178apr2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic179apr2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic180may2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic181may2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic182may2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic183jun2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic184jun2000.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic185jul2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic186jul2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic187aug2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic188aug2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic189sep2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic190sep2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic191oct2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic192oct2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic193nov2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic194nov2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic195nov2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic196dec2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic197dec2000Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic198jan2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic199jan2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic200feb2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic201feb2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic202mar2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic203mar2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic204apr2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic205apr2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic206may2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic207may2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic208may2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic209jun2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic210jun2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic211jul2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic212jul2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic213aug2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic214aug2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic215sep2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic216sep2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic217oct2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic218oct2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic219oct2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic220nov2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic221nov2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic222dec2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic223dec2001Reprint-NewContentOnly.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\261-100.jpg" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\275-100.jpg" -o "volumes\%TITLE%" -a

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

:: TAILS - VOLUME 2
:: ----------------

SET TITLE=Tails - Volume 2
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents2.png" -o "volumes\%TITLE%" -a

:: Tails - Hero of the Beach
%CBZ% extract "%ISSUE_DIR%\SonicTheComic111sep1997.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Tails - Channel Hoppers
%CBZ% extract "%ISSUE_DIR%\SonicTheComic112sep1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Tails - Fall of the Leaf
%CBZ% extract "%ISSUE_DIR%\SonicTheComic113sep1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic114oct1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Tails - Weather Beaten
%CBZ% extract "%ISSUE_DIR%\SonicTheComic115oct1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Sonic's World - Tall Tails
%CBZ% extract "%ISSUE_DIR%\SonicTheComic118dec1997.cbz" -p 15-19 -o "volumes\%TITLE%" -a

:: Tails - Going Crackers
%CBZ% extract "%ISSUE_DIR%\SonicTheComic119dec1997.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Tails + Knuckles - New Year Twister
%CBZ% extract "%ISSUE_DIR%\SonicTheComic120jan1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Tails - Recipe for Disaster
%CBZ% extract "%ISSUE_DIR%\SonicTheComic122feb1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Tails - Fashion Victims
%CBZ% extract "%ISSUE_DIR%\SonicTheComic125mar1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Tails - Desert Fox
%CBZ% extract "%ISSUE_DIR%\SonicTheComic126mar1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Tails - Fog Warning
%CBZ% extract "%ISSUE_DIR%\SonicTheComic127apr1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Tails - First Flight
%CBZ% extract "%ISSUE_DIR%\SonicTheComic128apr1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Tails - Clear As Mud
%CBZ% extract "%ISSUE_DIR%\SonicTheComic129may1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Tails - Making the News
%CBZ% extract "%ISSUE_DIR%\SonicTheComic131jun1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Tails - Cat Trick
%CBZ% extract "%ISSUE_DIR%\SonicTheComic132jun1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Tails - The Sky's The Limit
%CBZ% extract "%ISSUE_DIR%\SonicTheComic135jul1998.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Tails - Doctor Genius
%CBZ% extract "%ISSUE_DIR%\SonicTheComic138sep1998.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Tails - Bite Back
%CBZ% extract "%ISSUE_DIR%\SonicTheComic139sep1998.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Tails - Rat Race
%CBZ% extract "%ISSUE_DIR%\SonicTheComic140oct1998.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Tails - Skeleton Crew
%CBZ% extract "%ISSUE_DIR%\SonicTheComic141oct1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Tails - Rise and Fall
%CBZ% extract "%ISSUE_DIR%\SonicTheComic142nov1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Tails - The Goblin Overlords
%CBZ% extract "%ISSUE_DIR%\SonicTheComic143nov1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic144dec1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Tails - Captain Christmas
%CBZ% extract "%ISSUE_DIR%\SonicTheComic145dec1998.cbz" -p 15-19 -o "volumes\%TITLE%" -a

:: Tails - No More Heroes
%CBZ% extract "%ISSUE_DIR%\SonicTheComic148jan1999.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Tails - Forbidden Island
%CBZ% extract "%ISSUE_DIR%\SonicTheComic149feb1999.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Tails - Going Underground
%CBZ% extract "%ISSUE_DIR%\SonicTheComic150feb1999.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Tails - Northern Frights
%CBZ% extract "%ISSUE_DIR%\SonicTheComic151mar1999.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: AMY AND TEKNO
:: -------------

SET TITLE=Amy and Tekno
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents2.png" -o "volumes\%TITLE%" -a

:: Amy - In Good Hands
%CBZ% extract "%ISSUE_DIR%\SonicTheComic041dec1994.cbz" -p 31-34,30 -o "volumes\%TITLE%" -a

:: Amy in Snow Business
%CBZ% extract "%ISSUE_DIR%\SonicTheComic068jan1996.cbz" -p 25-29 -o "volumes\%TITLE%" -a

:: Amy's Adventures - Out for a Spin
%CBZ% extract "%ISSUE_DIR%\SonicTheComic095jan1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Sonic's World - Deception
%CBZ% extract "%ISSUE_DIR%\SonicTheComic105jun1997.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Sonic's World - Out of Work Hero
%CBZ% extract "%ISSUE_DIR%\SonicTheComic106jun1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Amy - Spot of Bother
%CBZ% extract "%ISSUE_DIR%\SonicTheComic108jul1997.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Amy - Star Struck
%CBZ% extract "%ISSUE_DIR%\SonicTheComic109aug1997.cbz" -p 23-27 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic110aug1997.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Sonic's World, Amy & Tekno - Spaced Out
%CBZ% extract "%ISSUE_DIR%\SonicTheComic111sep1997.cbz" -p 22-26 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic112sep1997.cbz" -p 23-27 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic113sep1997.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Sonic's World, Amy & Tekno - Earthbound
%CBZ% extract "%ISSUE_DIR%\SonicTheComic114oct1997.cbz" -p 23-27 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic115oct1997.cbz" -p 21-25 -o "volumes\%TITLE%" -a

:: Sonic's World, Amy & Tekno - Spooked
%CBZ% extract "%ISSUE_DIR%\SonicTheComic116nov1997.cbz" -p 22-26 -o "volumes\%TITLE%" -a

:: Sonic's World, Amy & Tekno - High in the Sky
%CBZ% extract "%ISSUE_DIR%\SonicTheComic117nov1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Sonic's World, Amy & Tekno - Multi-Mania
%CBZ% extract "%ISSUE_DIR%\SonicTheComic118dec1997.cbz" -p 21-25 -o "volumes\%TITLE%" -a

:: Sonic's World: Amy & Tekno - Peace of The Action
%CBZ% extract "%ISSUE_DIR%\SonicTheComic119dec1997.cbz" -p 22-26 -o "volumes\%TITLE%" -a

:: Sonic's World: Amy & Tekno - Breakout
%CBZ% extract "%ISSUE_DIR%\SonicTheComic120jan1998.cbz" -p 23-27 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic121jan1998.cbz" -p 21-25 -o "volumes\%TITLE%" -a

:: Sonic's World: Amy & Tekno - The Lump
%CBZ% extract "%ISSUE_DIR%\SonicTheComic124feb1998.cbz" -p 15-19 -o "volumes\%TITLE%" -a

:: Sonic's World: Amy & Tekno - Green Envy
%CBZ% extract "%ISSUE_DIR%\SonicTheComic125mar1998.cbz" -p 22-26 -o "volumes\%TITLE%" -a

:: Amy - Secret Past
%CBZ% extract "%ISSUE_DIR%\SonicTheComic127apr1998.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Amy - Yesterday's Heroes
%CBZ% extract "%ISSUE_DIR%\SonicTheComic128apr1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Amy - Fights, Camera, Action
%CBZ% extract "%ISSUE_DIR%\SonicTheComic129may1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Amy - Vane Hopes
%CBZ% extract "%ISSUE_DIR%\SonicTheComic132jun1998.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Amy - Following Suit
%CBZ% extract "%ISSUE_DIR%\SonicTheComic133jul1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Amy - Eternity Ring
%CBZ% extract "%ISSUE_DIR%\SonicTheComic134jul1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Amy - Prehistoric Ways
%CBZ% extract "%ISSUE_DIR%\SonicTheComic136aug1998.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Amy - Day of the Puppets
%CBZ% extract "%ISSUE_DIR%\SonicTheComic137aug1998.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Amy - Future Distractions
%CBZ% extract "%ISSUE_DIR%\SonicTheComic139sep1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a

:: Amy - Out of Time
%CBZ% extract "%ISSUE_DIR%\SonicTheComic140oct1998.cbz" -p 10-14 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic141oct1998.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Amy - Day One
%CBZ% extract "%ISSUE_DIR%\SonicTheComic142nov1998.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Amy - When in Romanus
%CBZ% extract "%ISSUE_DIR%\SonicTheComic143nov1998.cbz" -p 9-13 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic144dec1998.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Amy - Dream On
%CBZ% extract "%ISSUE_DIR%\SonicTheComic145dec1998.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Amy - New Year Out
%CBZ% extract "%ISSUE_DIR%\SonicTheComic146dec1998.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Amy - Small Talk
%CBZ% extract "%ISSUE_DIR%\SonicTheComic147jan1999.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Amy - The Thirteenth Task
%CBZ% extract "%ISSUE_DIR%\SonicTheComic149feb1999.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Amy - Treasure Seeker
%CBZ% extract "%ISSUE_DIR%\SonicTheComic152mar1999.cbz" -p 9-13 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic153apr1999.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Amy - Gangster Trap
%CBZ% extract "%ISSUE_DIR%\SonicTheComic154apr1999.cbz" -p 9-13 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic155may1999.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Amy - Full Circle
%CBZ% extract "%ISSUE_DIR%\SonicTheComic156may1999.cbz" -p 9-13 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic021mar1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic044feb1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic051may1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic068jan1996.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: SHINOBI
:: -------

SET TITLE=Shinobi
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Shinobi - The Dark Circle
::%CBZ% extract "%ISSUE_DIR%\TheOfficialSonicTheHedgehogYearbook1991.cbz" -p 36-43 -o "volumes\%TITLE%" -a

:: Shinobi - The Fear Pavilion
%CBZ% extract "%ISSUE_DIR%\Sonic the Comic 001 (May 1993).cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic002jun1993.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic003jun1993.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic004jul1993.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic005jul1993.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic006aug1993.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Shinobi - The Art of War
%CBZ% extract "%ISSUE_DIR%\SonicTheComic019feb1994.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic020mar1994.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic021mar1994.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic022apr1994.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic023apr1994.cbz" -p 20-24 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic024apr1994.cbz" -p 19-23 -o "volumes\%TITLE%" -a

:: Shinobi - Way of the Warrior
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 04 (1994).cbz" -p 2-7 -o "volumes\%TITLE%" -a

:: Shinobi - Power of The Elements
%CBZ% extract "%ISSUE_DIR%\SonicTheComic047mar1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic048mar1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic049apr1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic050apr1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic051may1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic052may1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic053jun1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic004jul1993.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic020mar1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic047mar1995.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\Sonic the Poster Mag 04 (1994).cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic051may1995.cbz" -p 12 -o "volumes\%TITLE%" -a

:: Back Cover
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

:: WONDER BOY
:: ----------

SET TITLE=Wonder Boy
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Wonder Boy in Demon World
%CBZ% extract "%ISSUE_DIR%\SonicTheComic002jun1993.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic003jun1993.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic004jul1993.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic005jul1993.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic006aug1993.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic007aug1993.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic008sep1993.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic009sep1993.cbz" -p 27-30 -o "volumes\%TITLE%" -a

:: Wonder Boy in Ghost World
%CBZ% extract "%ISSUE_DIR%\SonicTheComic022apr1994.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic023apr1994.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic024apr1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic025may1994.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic026may1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic027jun1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Covers
%CBZ% extract "%ISSUE_DIR%\SonicTheComic009sep1993.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Previews
%CBZ% extract "%ISSUE_DIR%\Sonic the Comic 001 (May 1993).cbz" -p 29 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: KID CHAMELEON
:: -------------

SET TITLE=Kid Chameleon
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Kid Chameleon
%CBZ% extract "%ISSUE_DIR%\SonicTheComic007aug1993.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic008sep1993.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic009sep1993.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic010oct1993.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic011oct1993.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic012oct1993.cbz" -p 13-17 -o "volumes\%TITLE%" -a

:: Kid Chameleon - Back to Unreality!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic054jun1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic055jul1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic056jul1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic057aug1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic058aug1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic059sep1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Previews
%CBZ% extract "%ISSUE_DIR%\Sonic the Comic 001 (May 1993).cbz" -p 28 -o "volumes\%TITLE%" -a

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

:: DECAP ATTACK
:: ------------

SET TITLE=Decap Attack
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents2.png" -o "volumes\%TITLE%" -a

:: Decap Attack - Starring Chuck D. Head!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic010oct1993.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic011oct1993.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic012oct1993.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic013nov1993.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic014nov1993.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic015dec1993.cbz" -p 26-29 -o "volumes\%TITLE%" -a

:: Decap Attack - Who Killed Chuck?
%CBZ% extract "%ISSUE_DIR%\SonicTheComic034sep1994.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic035sep1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic036oct1994.cbz" -p 25-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic037oct1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic038nov1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic039nov1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a

:: Dacap Attack - The Replacement
%CBZ% extract "%ISSUE_DIR%\SonicTheComic040dec1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a

:: Decap Attack - Monster of the Year
%CBZ% extract "%ISSUE_DIR%\SonicTheComic066dec1995.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic067dec1995.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic068jan1996.cbz" -p 13-17 -o "volumes\%TITLE%" -a

:: Decap Attack - The Headless Snowmen
%CBZ% extract "%ISSUE_DIR%\SonicTheComic069jan1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Decap Attack - Nanny Knows Best
%CBZ% extract "%ISSUE_DIR%\SonicTheComic070feb1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Decap Attack - The Bride of Chuck D. Head
%CBZ% extract "%ISSUE_DIR%\SonicTheComic071feb1996.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Decap Attack - The Pumpkin Chaser
%CBZ% extract "%ISSUE_DIR%\SonicTheComic089oct1996.cbz" -p 18-22 -o "volumes\%TITLE%" -a

:: Decap Attack - Boris & The Book
%CBZ% extract "%ISSUE_DIR%\SonicTheComic090nov1996.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Decap Attack - The Legend of Mr Cuddle Bunny
%CBZ% extract "%ISSUE_DIR%\SonicTheComic091nov1996.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic092dec1996.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic093dec1996.cbz" -p 18-22 -o "volumes\%TITLE%" -a

:: Decap Attack - The Hungry Guest
%CBZ% extract "%ISSUE_DIR%\SonicTheComic094jan1997.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Decap Attack - Dead!
%CBZ% extract "%ISSUE_DIR%\SonicTheComic097feb1997.cbz" -p 15-19 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic098mar1997.cbz" -p 15-19 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic099mar1997.cbz" -p 15-19 -o "volumes\%TITLE%" -a

:: Decap Attack - Walls
%CBZ% extract "%ISSUE_DIR%\SonicTheComic101apr1997.cbz" -p 15-19 -o "volumes\%TITLE%" -a

:: Decap Attack - Life with the Snagsbys
%CBZ% extract "%ISSUE_DIR%\SonicTheComic102apr1997.cbz" -p 15-19 -o "volumes\%TITLE%" -a

:: Decap Attack - Funny Old Game
%CBZ% extract "%ISSUE_DIR%\SonicTheComic104may1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Decap Attack - Wish
%CBZ% extract "%ISSUE_DIR%\SonicTheComic105jun1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Decap Attack - Caught by the Prefects
%CBZ% extract "%ISSUE_DIR%\SonicTheComic107jul1997.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic108jul1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Decap Attack - Dreaded Poople Plague
%CBZ% extract "%ISSUE_DIR%\SonicTheComic109aug1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Decap Attack - The Tooth
%CBZ% extract "%ISSUE_DIR%\SonicTheComic110aug1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Decap Attack - The Maltese Budgies
%CBZ% extract "%ISSUE_DIR%\SonicTheComic111sep1997.cbz" -p 15-19 -o "volumes\%TITLE%" -a

:: Decap Attack - The Fearless Monster Hunters
%CBZ% extract "%ISSUE_DIR%\SonicTheComic113sep1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Decap Attack - Chuck and the Cheese Factory
%CBZ% extract "%ISSUE_DIR%\SonicTheComic114oct1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic115oct1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Decap Attack - Return of the Pumpkins
%CBZ% extract "%ISSUE_DIR%\SonicTheComic116nov1997.cbz" -p 17-21 -o "volumes\%TITLE%" -a

:: Decap Attack - Christmas Carol II
%CBZ% extract "%ISSUE_DIR%\SonicTheComic119dec1997.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Decap Attack - Chuck's Savings
%CBZ% extract "%ISSUE_DIR%\SonicTheComic120jan1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Decap Attack - Love is Blind
%CBZ% extract "%ISSUE_DIR%\SonicTheComic123feb1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Decap Attack - Dog
%CBZ% extract "%ISSUE_DIR%\SonicTheComic125mar1998.cbz" -p 15-19 -o "volumes\%TITLE%" -a

:: Decap Attack - Mother
%CBZ% extract "%ISSUE_DIR%\SonicTheComic126mar1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Decap Attack - The Dungeon
%CBZ% extract "%ISSUE_DIR%\SonicTheComic129may1998.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Decap Attack - Birthday
%CBZ% extract "%ISSUE_DIR%\SonicTheComic130may1998.cbz" -p 23-27 -o "volumes\%TITLE%" -a

:: Decap Attack - Decap-Man
%CBZ% extract "%ISSUE_DIR%\SonicTheComic131jun1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic132jun1998.cbz" -p 16-20 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic010oct1993.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic012oct1993.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic034sep1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic066dec1995.cbz" -p 1 -o "volumes\%TITLE%" -a

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

:: ETERNAL CHAMPIONS
:: -----------------

SET TITLE=Eternal Champions
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Eternal Champions
%CBZ% extract "%ISSUE_DIR%\SonicTheComic019feb1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic020mar1994.cbz" -p 13-17 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic021mar1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic022apr1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic023apr1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic024apr1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Eternal Champions - Larson's Revenge
%CBZ% extract "%ISSUE_DIR%\SonicTheComic037oct1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic038nov1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic039nov1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic040dec1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic019feb1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic024apr1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic039nov1994.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: PIRATE S.T.C
:: ------------

SET TITLE=Pirate STC
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Pirate S.T.C
%CBZ% extract "%ISSUE_DIR%\SonicTheComic028jun1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic029jul1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic030jul1994.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic031aug1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic032aug1994.cbz" -p 26-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic033sep1994.cbz" -p 25-28 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic028jun1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic027jun1994.cbz" -p 32 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic029jul1994.cbz" -p 32 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: MUTANT LEAGUE
:: -------------

SET TITLE=Mutant League
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Mutant League - Bring Me The Head of Coach Brikka
%CBZ% extract "%ISSUE_DIR%\SonicTheComic031aug1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic032aug1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic033sep1994.cbz" -p 11-15 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic034sep1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic035sep1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic036oct1994.cbz" -p 12-16 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover gallery
%CBZ% extract "%ISSUE_DIR%\SonicTheComic031aug1994.cbz" -p 1 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic030jul1994.cbz" -p 33 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: MARKO'S MAGIC FOOTBALL
:: ----------------------

SET TITLE=Marko's Magic Football
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Marko's Magic Football
%CBZ% extract "%ISSUE_DIR%\SonicTheComic041dec1994.cbz" -p 37-40 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic042jan1995.cbz" -p 39-42 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic043jan1995.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic044feb1995.cbz" -p 28-31 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic045feb1995.cbz" -p 27-30 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic046mar1995.cbz" -p 26-29 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: SPARKSTER
:: ---------

SET TITLE=Sparkster
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Sparkster - Last of the Rocket Knights
%CBZ% extract "%ISSUE_DIR%\SonicTheComic053jun1995.cbz" -p 25-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic054jun1995.cbz" -p 25-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic055jul1995.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic056jul1995.cbz" -p 25-29 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic057aug1995.cbz" -p 24-28 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic058aug1995.cbz" -p 25-29 -o "volumes\%TITLE%" -a

:: Cover gallery seperator
%CBZ% extract "data\%TITLE%\cover_gallery.png" -o "volumes\%TITLE%" -a

:: Cover - Sparkster
%CBZ% extract "%ISSUE_DIR%\SonicTheComic055jul1995.cbz" -p 1 -o "volumes\%TITLE%" -a

:: Back Cover
%CBZ% extract "data\%TITLE%\back_cover.png" -o "volumes\%TITLE%" -a

:: SHINING FORCE
:: -------------

SET TITLE=Shining Force
mkdir "volumes\%TITLE%"
copy /s /q "data\%TITLE%\tag.txt" "volumes\%TITLE%" > NUL

:: Title and contents
%CBZ% extract "data\%TITLE%\front_cover.png" -o "volumes\%TITLE%" -a
%CBZ% extract "data\%TITLE%\contents.png" -o "volumes\%TITLE%" -a

:: Shining Force - The Curse of Zeon
%CBZ% extract "%ISSUE_DIR%\SonicTheComic073mar1996.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic074mar1996.cbz" -p 19-23 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic075apr1996.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic076apr1996.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic077may1996.cbz" -p 17-21 -o "volumes\%TITLE%" -a
%CBZ% extract "%ISSUE_DIR%\SonicTheComic078may1996.cbz" -p 19-23 -o "volumes\%TITLE%" -a

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
