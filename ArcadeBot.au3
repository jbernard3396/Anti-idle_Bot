#include-once

;arcade helpers
func Arcade($isTrue)
    navToArcade()
   ;game playing logic
   ;for $i = 0 To 10000
	  ;houseKeeping()
	  ;majorHouseKeeping()
	  navToArcade()
;~ 	  playBalance()
	  playWAG()
   ;Next
EndFunc

func navToArcade()
   ;go to arcade
   MouseMove(953, 331)
   sleep(500)
   MouseClick("left",946, 486, 1, 5)
   sleep(100)
   ;click Start
   MouseClick("left",829, 530, 1, 5)

EndFunc

func playWAG()
   ;MUST be in arcade for this to work (helper for Arcade())
   ;select game
   Local $redColor = 0x950809
   Local $whiteApprox = 0xF7ECED
   Local $backApprox =  0x1A0A09
   $backApprox = 0x1F1807
   _ColorConvertHSLtoRGB($backApprox)
   _ColorConvertHSLtoRGB($whiteApprox)
   local $TR[2]
   $TR[0] = 495+31
   $TR[1] = 373+16



   MouseClick("left",688, 462, 1, 5)
   ;click play
   MouseClick("left",532, 566, 1, 5)
   sleep(3500)
   Local $keepGoing = true

   Local $inARowCount = 0
   while $keepGoing
	  for $i = 0 To 11
		 for $j = 0 To 5
			;MouseMove($TR[0]+(40*$i), $TR[1] + (40*$j), 1)

			Local $thisColor = PixelGetColor($TR[0]+(40*$i), $TR[1] + (40*$j))
			_ColorConvertHSLtoRGB($thisColor)
			if ($thisColor >= $backApprox+1000000 And $thisColor <= $whiteApprox-1000000) then;<= $redColor+1000000 and $thisColor >= $redColor-10000000) Then
				  MouseClick("left", $TR[0]+(40*$i), $TR[1] + (40*$j), 1, 1)
				  ;increment column to avoid clicking immediately after clicking combo
				  $i += 2
				  $i = Mod($i, 11)
				  sleep(50)
				  $inARowCount = $inARowCount+1
			Else
				  $inARowCount = 0
			EndIf
			If ($inARowCount >=4) Then
			   ExitLoop(3)
			EndIf

		 Next
	  Next
   WEnd
   ;hit back
   ;print("function over", 1000)
   $globalWAGCounter = $globalWAGCounter+1
   WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
   MouseClick("left", 730, 589, 1, 5)

EndFunc

func playAvoid()
   ;MUST be called from arcade screen

   Local $safeBox[4]
   $safeBox[0] = 600
   $safeBox[1] = 350
   $safeBox[2] = 700
   $safeBox[3] = 400
   Local $safeCenter[2]
   $safeCenter[0] = ($safeBox[0] + $safeBox[2])/2
   $safeCenter[1] = ($safeBox[1] + $safeBox[3])/2

   Local $multiplierColor = 0x656225

   Local $redColor = 0xFD0D00

   Local $safeX = 20
   Local $safeY = 30
   ;select game
   MouseClick("left",659, 421, 1, 5)
   ;click play
   MouseClick("left",532, 566, 1, 5)
   sleep(4000)
   Local $keepGoing = true
   while $keepGoing
	  Local $safeSpace[2]
	  $safeSpace[0] = 0
	  $safeSpace[1] = 0
	  ;search for red pixels in safe box
	  $BoxDanger = PixelSearch($safeBox[0], $safeBox[1], $safeBox[2], $safeBox[3], $redColor, 50)
	  Local $multLoc ;= PixelSearch($screenCoordsArray[0],$screenCoordsArray[1],$screenCoordsArray[2],$screenCoordsArray[3],$multiplierColor)
	  if (isArray($BoxDanger)) Then ; there is a red pixel
		 $safeSpace = PixelSearch(($screenCoordsArray[0]+$safeX), (($BoxDanger[1])-1), $screenCoordsArray[2], (($BoxDanger[1])), 0x3D3D30)
		 if(isArray($safeSpace)) Then
			if ($safeSpace<($screenCoordsArray[0]+$safeX)+15) Then
			   MouseMove($safeSpace[0], $safeCenter[1],1)
			Else
			   MouseMove($safeSpace[0]+10, $safeCenter[1],1)
			EndIf
			sleep(500)
			;print($safeSpace[0])
		 EndIf

		 ;print("true")
		 ;WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
	  ElseIf (IsArray($multLoc)) Then
		 Local $anyRed = PixelSearch($screenCoordsArray[0],$screenCoordsArray[1],$screenCoordsArray[2],$screenCoordsArray[3],$redColor)
		 if (IsArray($anyRed)=False) Then
			MouseMove($multLoc[0], $multLoc[1],1)
		 EndIf


	  Else
		 MouseMove($safeCenter[0], $safeCenter[1], 1)
		 if (PixelGetColor(633, 376) = 0x92E8F1) Then
			houseKeeping()
			;game is over, select back
			MouseClick("left", 750, 597, 1)
			;select play
			MouseClick("left",532, 566, 1, 5)
		 EndIf
	  EndIf
;~ 	  $safePixelT = PixelSearch($screenCoordsArray[0], $screenCoordsArray[1], $screenCoordsArray[2], $screenCoordsArray[3], 0x3D3D30)
;~ 	  ;search from bottom
;~ 	  $safePixelB = PixelSearch($screenCoordsArray[2], $screenCoordsArray[3], $screenCoordsArray[0], $screenCoordsArray[1], 0x3D3D30)
;~ 	  if (PixelGetColor($safePixelT[0]+$safeX, $safePixelT[1]+$safeY) = 0x3D3D30)Then
;~ 		  MouseMove($safePixelT[0]+$safeX, $safePixelT[1]+$safeY,1)
;~ 	  EndIf
   WEnd
EndFunc

func playBalance()
   Local $ColorLoc[2]
   $ColorLoc[0] =596
   $ColorLoc[1] =437
   Local $greenColor  = 0x0DFF00
   Local $redColor    = 0xFF0D00
   Local $yellowColor = 0xFFFF00

   Local $blackColor  = 0x0D0D00

   Local $yellowBlock = 0xFFFF18
   Local $redBlock    = 0xFF2518
   Local $greenBlock  = 0x25FF18
   Local $blockHeight = 20
   Local $arrowHeight = 40
   Local $fX = 685
   Local $sX = 735
   Local $tX = 785
   Local $roof = 450
   Local $redCount = 0
   Local $greenCount = 0
   Local $yellowCount = 0

   ;arrays to store what is currently in the collumn
   Local $Array1[8]
   Local $array1Count = 0
   for $i = 0 To 7
	  $Array1[$i] = 0
   Next
   Local $Array2[8]
   Local $array2Count = 0
   for $i = 0 To 7
	  $Array2[$i] = 0
   Next
   Local $Array3[8]
   Local $array3Count = 0
   for $i = 0 To 7
	  $Array3[$i] = 0
   Next

   ;record what number was generated
   ;1=green 2 = yellow 3 = red 0 = nothing
   Local $thisNumber = -1
   ;boolean to check if block is Random
   Local $isRandom = False
   ;open game
   MouseClick("left", 668, 523, 10)
   ;click PLay
   MouseClick("left", 558, 577, 10)
   houseKeeping()
   sleep(4000)
   Local $keepGoing = True
   While $keepGoing
	  if (PixelGetColor(736, 585) = 0xA6A6D7) Then
		 ;game is over, turn off keep going
		 $keepGoing = False
		 MouseClick("left", 736, 585)
		 MouseClick("left", 699, 572)
		 ExitLoop
	  EndIf
;~ 	  if (Random(0,10,1) = 0) Then
;~ 		 Print("AC: " & $array3Count)
;~ 		 if ($array3Count>0) Then
;~ 			for $i = 0 to $array3Count-1
;~ 			   Print($Array1[$i],100)


;~ 			Next
;~ 		 EndIf
;~ 		 WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
;~ 	  EndIf
	  Local $thisColor = PixelGetColor($ColorLoc[0], $ColorLoc[1])
	  if ($thisColor =$greenColor)Then
		 $thisNumber = 1
		 $isRandom = False
	  Elseif ($thisColor = $yellowColor)Then
		 $thisNumber = 2
		 $isRandom = False
	  ElseIf($thisColor = $redColor)Then
		 $thisNumber = 3
		 $isRandom = False
	  Else
		 ;$thisNumber = -1
		 $isRandom = True
	  EndIf

	  ;handle random block first because it is quickest
	  if ($isRandom = True) Then
		 Send("{RIGHT}")
		 Local $baseOfTS = PixelSearch($tX, $roof, ($tX+1), 636,$blackColor)
		 Local $newBlock[2]
;~ 		 MouseMove($baseOfTS[0], $baseOfTS[1])
;~ 		 Sleep(1000)
		 $newBlock[0] = $baseOfTS[0]+8
		 $newBlock[1] = $baseOfTS[1]-($arrowHeight+($array3Count*$blockHeight)+5)
		 MouseMove($newBlock[0], $newBlock[1],1)
		 Sleep(400)
		 Local $randomColor = PixelGetColor($newBlock[0], $newBlock[1])
;~ 		 Print("random")
;~ 		 Print($randomColor)
;~ 		 Print($redColor)
;~ 		 Print($greenColor)
;~ 		 Print($yellowColor)
;~ 		 WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
		 if ($randomColor = $greenBlock) Then
;~ 			Print("green")
;~ 			WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
			$Array3[$array3Count] = 1
			$array3Count = $array3Count + 1
		 ElseIf ($randomColor = $yellowBlock) Then
;~ 			Print("yellow")
;~ 			WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
			$Array3[$array3Count] = 2
			$array3Count = $array3Count + 1
		 ElseIf ($randomColor = $redBlock) Then
;~ 			Print("red")
;~ 			WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
			$Array3[$array3Count] = 3
			$array3Count = $array3Count + 1
		 Else ;random block was the third in a row, clearing three
;~ 			Print("grey")
;~ 			WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
			;reset the top two in the array
			$Array3[$array3Count] = 0
			$Array3[$array3Count-1] = 0
			;remove two from the array
			$array3Count = $array3Count - 2
		 EndIf
		 ;Sleep(500)

		 if ($array3Count >= 3) Then
			if ($Array3[$array3Count-1] = $Array3[$array3Count-2] And $Array3[$array3Count-1] = $Array3[($array3Count-3)]) Then
			   $Array3[$array3Count-1] = 0
			   $Array3[$array3Count-2] = 0
			   $Array3[$array3Count-3] = 0
			   $array3Count = $array3Count - 3
			EndIf
		 EndIf
;~ 		 Print("AC: " & $array3Count)
;~ 		 if ($array3Count>0) Then
;~ 			for $i = 0 to $array3Count-1
;~ 			   Print($Array3[$i],100)


;~ 			Next
;~ 		 EndIf
		 WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
		 ;Print($randomColor, 2000)
		 ;WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
;~ 		 Sleep(1000)
	  EndIf

	  ;if this collor of block is in column, add this block to that column
	  if ($isRandom = False) Then
		 if ($array3Count>= 1 And  $Array3[$array3Count-1] = $thisNumber) Then
			Send("{RIGHT}")
			$Array3[($array3Count)] = $thisNumber
			$array3Count=$array3Count+1
			if ($array3Count >=3 And $Array3[$array3Count-1] = $Array3[$array3Count-2] And $Array3[$array3Count-1] = $Array3[$array3Count-3]) Then
			   $Array3[$array3Count-1] = 0
			   $Array3[$array3Count-2] = 0
			   $Array3[$array3Count-3] = 0
			   $array3Count = $array3Count - 3
			EndIf
		 ElseIf ( $array1Count>= 1 And $Array1[$array1Count-1] = $thisNumber) Then
			Send("{LEFT}")
			$Array1[($array1Count)] = $thisNumber
			$array1Count=$array1Count+1
			if ($array1Count >=3 And $Array1[$array1Count-1] = $Array1[$array1Count-2] And $Array1[$array1Count-1] = $Array1[$array1Count-3]) Then
			   $Array1[$array1Count-1] = 0
			   $Array1[$array1Count-2] = 0
			   $Array1[$array1Count-3] = 0
			   $array1Count = $array1Count - 3
			EndIf
		 ElseIf ($array2Count>= 1 And $Array2[$array2Count-1] = $thisNumber) Then
			Send("{DOWN}")
			$Array2[($array2Count)] = $thisNumber
			$array2Count=$array2Count+1
			if ($array2Count >=3 And $Array2[$array2Count-1] = $Array2[$array2Count-2] And $Array2[$array2Count-1] = $Array2[$array2Count-3]) Then
			   $Array2[$array2Count-1] = 0
			   $Array2[$array2Count-2] = 0
			   $Array2[$array2Count-3] = 0
			   $array2Count = $array2Count - 3
			EndIf

		 ;if a collumn is empty, add this block to that column
		 ElseIf($array1Count <=$array2Count And $array1Count <= $array3Count) Then
			Send("{LEFT}")
			$Array1[($array1Count)] = $thisNumber
			$array1Count=$array1Count+1
			if ($array1Count >=3 And $Array1[$array1Count-1] = $Array1[$array1Count-2] And $Array1[$array1Count-1] = $Array1[$array1Count-3]) Then
			   $Array1[$array1Count-1] = 0
			   $Array1[$array1Count-2] = 0
			   $Array1[$array1Count-3] = 0
			   $array1Count = $array1Count - 3
			EndIf
		 ElseIf($array2Count <=$array1Count And $array2Count <= $array3Count) Then
			Send("{DOWN}")
			$Array2[($array2Count)] = $thisNumber
			$array2Count=$array2Count+1
			if ($array2Count >=3 And $Array2[$array2Count-1] = $Array2[$array2Count-2] And $Array2[$array2Count-1] = $Array2[$array2Count-3]) Then
			   $Array2[$array2Count-1] = 0
			   $Array2[$array2Count-2] = 0
			   $Array2[$array2Count-3] = 0
			   $array2Count = $array2Count - 3
			EndIf
		 ElseIf($array3Count <= $array1Count And $array3Count <=$array2Count) Then
			Send("{RIGHT}")
			$Array3[($array3Count)] = $thisNumber
			$array3Count=$array3Count+1
			if ($array3Count >=3 And $Array3[$array3Count-1] = $Array3[$array3Count-2] And $Array3[$array3Count-1] = $Array3[$array3Count-3]) Then
			   $Array3[$array3Count-1] = 0
			   $Array3[$array3Count-2] = 0
			   $Array3[$array3Count-3] = 0
			   $array3Count = $array3Count - 3
			EndIf
		 Else
			Print("Borken")
		 EndIf
	  EndIf


;~ 	  if ($thisColor =$greenColor)Then
;~ 		 Send("{LEFT}")
;~ 		 $greenCount = $greenCount+1
;~ 		 if ($greenCount >= 3)Then
;~ 			$greenCount = 0
;~ 		 EndIf
;~ 	  Elseif ($thisColor = $yellowColor)Then
;~ 		 Send("{DOWN}")
;~ 		 $yellowCount = $yellowCount+1
;~ 		 if ($yellowCount >= 3)Then
;~ 			$yellowCount = 0
;~ 		 EndIf
;~ 	  ElseIf($thisColor = $redColor)Then
;~ 		 Send("{RIGHT}")
;~ 		 ;print($redCount)
;~ 		 ;WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
;~ 		 ;sleep(20)
;~ 		 $redCount = $redCount+1
;~ 		 if ($redCount >= 3)Then
;~ 			$redCount = 0
;~ 		 EndIf
;~ 	  Else
;~ 		 Send("{RIGHT}")
;~ 		 print($redCount)
;~ 		 WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
;~ 		 Local $baseOfTS = PixelSearch($tX, $roof, ($tX+1), 636,$blackColor)
;~ 		 Local $newBlock[2]
;~ 		 MouseMove($baseOfTS[0], $baseOfTS[1])
;~ 		 Sleep(1000)
;~ 		 $newBlock[0] = $baseOfTS[0]
;~ 		 $newBlock[1] = $baseOfTS[1]-($arrowHeight+($redCount*$blockHeight)+5)
;~ 		 MouseMove($newBlock[0], $newBlock[1])
;~ 		 Sleep(1000)
;~ 	  EndIf
;~ 	  sleep(0)
   Wend
EndFunc

