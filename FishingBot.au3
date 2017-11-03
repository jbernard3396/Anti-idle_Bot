#include-once
;fishing helpers
func fishing($iters)
   ;not sure if blue color is right?
   Local $orange      = 0xFF7F00
   Local $perfectBlue = 0x00FDFD
   Local $perfectRed = 0xFF0000
   Local $perfectColor = 0x000000
   Local $fishingArea[4]
   $fishingArea[0] = 768
   $fishingArea[1] = 640
   $fishingArea[2] = 970
   $fishingArea[3] = 658

   Local $comboCount = 0

   WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
   Local $count = 0
   ;openmenu
   MouseMove(953, 331)
   sleep(500)
   ;click fishing
   MouseClick("left",942, 607, 1, 5)
   sleep(100)
   ;closeMenu
   MouseMove(500,500,2)

   ;sell junk
   ;sellJunk()

   while $count < $iters/5
	  if ((checkFatigue(False)) = True) Then
		 print("fatigued")
		 WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
		 if (recoverFatigue() = False) Then
			print("still fatigued")
			WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
			$iters=0
		 EndIf
	  Else
	    ;print("n f")
		;WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
		MouseMove(0,0,1)
	  EndIf
	  $globalFishingCounter = $globalFishingCounter+1
	  $count = $count +1
	  if (Mod($count, 30) = 0) Then
		 houseKeeping()
	  EndIF
	  ;print("while loop beginning", 500)
	  ;WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
	  Local $PerfectPixel = 0
	  while (IsArray($perfectPixel) = false)
		 $PerfectPixel= PixelSearch($fishingArea[0],$fishingArea[1],$fishingArea[2],$fishingArea[3], $perfectBlue)
		 Local $perfectColor = $perfectBlue
		 if (IsArray($PerfectPixel) = False) Then
			$perfectColor = $perfectRed
			$PerfectPixel = PixelSearch($fishingArea[0],$fishingArea[1],$fishingArea[2],$fishingArea[3], $perfectRed)
		 EndIf
	  WEnd
	  $orangeLoc = null
	  while (PixelGetColor($PerfectPixel[0], $PerfectPixel[1]) = $perfectColor)
		 if (PixelGetColor($PerfectPixel[0]-1, $PerfectPixel[1])  = $perfectColor)Then
			$PerfectPixel[0] = $PerfectPixel[0] - 1
		 EndIf
		 if ($orangeLoc = null) Then
			$orangeLoc = PixelSearch($screenCoordsArray[0],$screenCoordsArray[1],$screenCoordsArray[2],$screenCoordsArray[3], $orange)
			if (isArray($orangeLoc)) Then
			   sleep(500)
			   $orangeLoc2 = PixelSearch($screenCoordsArray[0],$screenCoordsArray[1],$screenCoordsArray[2],$screenCoordsArray[3], $orange)
			   if ($orangeLoc[1] < $orangeLoc2[1]) Then
				  $direction = 1
			   EndIf
			Else
			   $orangeLoc = null
			EndIf
			Local $direction = -1

		 EndIf

		 Local $yAdd = random(1,2,1)
		 MouseMove($PerfectPixel[0], $PerfectPixel[1]-$yAdd)
	  WEnd
	  if ($direction = -1) Then
		 sleep(80)
	  EndIf
	  sleep(30)
	  ;print("fishing ok", 1000)
	  ;WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
	  send("{space}")
	  sleep(100)
	  ;close possible menu
	  MouseClick("left", 959, 417)

   WEnd
   ;level up Mastery
   MouseClick("left", 826, 348, 1, 10)


EndFunc

func checkFatigue($isHeavy)
   ;call this from fishing screen to see if you are nearly fully fatigued
   ;location to check for high fatigue
   Local $vfatigueLoc[2]
   $vfatigueLoc[0] =764
   $vfatigueLoc[1] =367
   ;location to check for Medium fatigue
   Local $mFatigueLoc[2]
   $mFatigueLoc[0] = 667
   $mFatigueLoc[1] = 366

   Local $fatigueLoc[2]
   ;assign fatigue based on passed in variable
   if ($isHeavy = True) Then
	  $fatigueLoc[0] =  $vfatigueLoc[0]
	  $fatigueLoc[1] =  $vfatigueLoc[1]
   ElseIf($isHeavy = False) Then
	  $fatigueLoc[0] =  $mFatigueLoc[0]
	  $fatigueLoc[1] =  $mFatigueLoc[1]
	Else
	  $break
   EndIf


   Local $fatigueColor = 0xB64242
   _ColorConvertHSLtoRGB($fatigueColor)

   ;MouseMove($fatigueLoc[0],$fatigueLoc[1])
   Local $currentColor = PixelGetColor($fatigueLoc[0], $fatigueLoc[1])
   _ColorConvertHSLtoRGB($currentColor)
   if ($currentColor > $fatigueColor-500000 And $currentColor <$fatigueColor+500000) Then
	  ;print("fatigued")
	  ;WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
	  return (true)
   Else
	  ;print("not fatigued")
	  ;WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
	  return (false)
   EndIf

EndFunc

func recoverFatigue()
   ;call from fishing screen

   Local $regDrinkColor = 0xAF622F
   Local $regDrinkLoc[2]
   $regDrinkLoc[0] = 818
   $regDrinkLoc[1] = 553

   Local $eliteDrinkColor = 0xAF622F
   Local $eliteDrinkLoc[2]
   $eliteDrinkLoc[0] = 816
   $eliteDrinkLoc[1] = 571

   Local $firstFishLoc[2]
   $firstFishLoc[0] = 804
   $firstFishLoc[1] = 427

   ;open bucket
   MouseClick("left", 596, 501, 1, 3)
   ;switch to special
   MouseClick("left", 622, 400, 1, 3)
   ;drink reg drink if available

   ;MouseMove($regDrinkLoc[0], $regDrinkLoc[1])
   if (PixelGetColor($regDrinkLoc[0], $regDrinkLoc[1]) = $regDrinkColor) Then
	  ;print("have drinks")
	  ;WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
	  MouseClick("left", $regDrinkLoc[0], $regDrinkLoc[1], 1, 10)
   EndIf

   ;check if still fatigued
   if (checkFatigue(False)=true) Then
	  ;check if we have elite energy drinks
	  if (PixelGetColor($regDrinkLoc[0], $regDrinkLoc[1]) = $regDrinkColor) Then
		 ;drink elite energy drinks
		 ;print("have drinks")
		 ;WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
		 MouseClick("left", $eliteDrinkLoc[0], $eliteDrinkLoc[1], 1, 10)
	  EndIf
   EndIf

   ;switch to Fish [1]
   MouseClick("left", 846, 402, 1, 3)

   ;check if still fatigued
   if (checkFatigue(False)=true) Then
		 ;eat fish
		 for $i = 0 To 9
			if (checkFatigue(false) = true) Then
			   for $j = 0 To 10
				  MouseClick("left", $firstFishLoc[0], $firstFishLoc[1]+(20*$i), 1, 10)
			   Next
			EndIf
		 Next
	  EndIf

   ;switch to Fish [2]
   MouseClick("left", 926, 403, 1, 3)

   ;check if still fatigued
   if (checkFatigue(False)=true) Then
		 ;eat fish
		 for $i = 0 To 9
			if (checkFatigue(false) = true) Then
			   for $j = 0 To 10
				  MouseClick("left", $firstFishLoc[0], $firstFishLoc[1]+(20*$i), 1, 10)
			   Next
			EndIf
		 Next
   EndIf

   ;close bucket
   MouseClick("left", 975, 402, 1,10)

EndFunc

func sellJunk()
   ;Call from fishing screen

   Local $fishLoc[2]
   $fishLoc[0] = 897
   $fishLoc[1] = 427

   ;open bucket
   MouseClick("left", 596, 501, 1, 5)
   ;switch to junk
   MouseClick("left", 686, 401, 1, 3)

   for $i = 0 To 9
	  MouseClick("left", $fishLoc[0], $fishLoc[1] + ($i*20), 20, 1)
   Next

   ;switch to Junk2
   MouseClick("left", 767, 403, 1, 3)
   for $i = 0 To 9
	  MouseClick("left", $fishLoc[0], $fishLoc[1] + ($i*20), 20, 1)
   Next

   ;close bucket
   MouseClick("left", 975, 402, 1, 10)
EndFunc
