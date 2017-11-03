;;Center screen
#include-once
#include <C:\Users\jbern\Documents\Bots\UsefulInclude.au3>

func isScreenCentered($topLeftPixel, $debug = false)
   $leftOfTopLeftPixel = PixelGetColor($topLeftPixel[0] - 2, $topLeftPixel[1])
   $aboveTopLeftPixel  = PixelGetColor($topLeftPixel[0], $topLeftPixel[1] - 2)
   $acrossFromTopLeftPixel = PixelGetColor($topLeftPixel[0] - 2, $topLeftPixel[1] - 2)
   $topLeftPixel = PixelGetColor($topLeftPixel[0], $topLeftPixel[1])

   if ($debug) Then
	  print("left-same:")
	  print($leftOfTopLeftPixel)
	  print("over-same:")
	  print($aboveTopLeftPixel)
	  print("across-same:")
	  print($acrossFromTopLeftPixel)
	  print("center-different:")
	  print($topLeftPixel, 200)
   EndIf
   if threeValuesAreEqual($leftOfTopLeftPixel, $aboveTopLeftPixel, $acrossFromTopLeftPixel) then
	  if ($topLeftPixel <> $leftOfTopLeftPixel) Then
		 if ($debug) Then
			print("Screen is centered!", 50)
		 EndIf
		 return 1
	  EndIf
   EndIf
   return 0
EndFunc

func threeValuesAreEqual($value1, $value2, $value3)
   if ($value1 == $value2) Then
	  if ($value2 == $value3) Then
		 if ($value1 == $value3) Then
			return True
		 EndIf
	  EndIf
   EndIf
   return False
EndFunc

func centerScreen($positionToSetScrollBar, $windowTitle, $topLeftPixel)
   WinActivate($windowTitle)
   MouseMove(1910, 88)
   MouseWheel('up', 10)
   sleep(150)
   MouseDown("left")
   MouseMove(1910, $positionToSetScrollBar, 10)
   MouseUp("left")
   return(isScreenCentered($topLeftPixel))
EndFunc

func centerScreenForAntiIdle()
   local $start = 120
   local $windowHandle = "Play Anti-Idle: The Game, a free online game on Kongregate"
   print(isScreenCentered($topLeftPixelArray, false))
   if (isScreenCentered($topLeftPixelArray, false) == 1) Then
	  Return
   EndIf
   centerScreen($start,$windowHandle, $topLeftPixelArray)
   if (isScreenCentered($topLeftPixelArray, false) <> 1) Then
	  print("error centering screen for anti-idle", 100)
	  for $increment = $start-5 to ($start + 2)
		 print("increment:")
		 print($increment, 100)
		 centerScreen($increment, $windowHandle, $topLeftPixelArray)
		 if (isScreenCentered($topLeftPixelArray, false) == 1) Then
			print("reccomended correct centering point:")
			print($increment)
			Return
		 EndIf
	  Next
	  print("could not find correct screen", 100)
   EndIf
EndFunc

Local $topLeftPixelArray[2]
$topLeftPixelArray[0] = 464
$topLeftPixelArray[1] = 213
