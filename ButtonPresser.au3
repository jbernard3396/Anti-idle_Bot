;button helpers
#include-once
#include <C:\Users\jbern\Documents\Bots\UsefulInclude.au3>
;;;;WARNING: problem with returning average pixel/ finding best click when there is no button
;;;;WORKING ON PERFECT CLICK CHECK --- try using a search in a box where the status should be?

func navigateToButtonRoom()
   if (weAreInButtonRoom() <> 1) then
	  ;move over world menu
	  MouseMove(953, 331)
	  sleep(50)
	  ;click button
	  MouseClick("left",947, 438, 1, 5)
	  sleep(100)
	  ;close menu
	  MouseMove(500,500,5)
   EndIf
EndFunc

func weAreInButtonRoom()
   if (identifyButtonColor() == 0xC86400) Then
	  return True
   EndIf
EndFunc

func setup()
   global $repairButtonColor = 0xAFAF2F
   global $repairButtonArray[4]
   $repairButtonArray[0] = 497
   $repairButtonArray[1] = 645
   $repairButtonArray[2] = 629
   $repairButtonArray[3] = 656

   global $nearBreakColor = 0x990000
   global $nearBreakArray[4]
   $nearBreakArray[0] =551
   $nearBreakArray[1] =407
   $nearBreakArray[2] =930
   $nearBreakArray[3] =515

   global $buttonCoordsArray[4]
   $buttonCoordsArray[0] = 528
   $buttonCoordsArray[1] = 380
   $buttonCoordsArray[2] = 937
   $buttonCoordsArray[3] = 655

   global $fastSleepTime = 10
   global $slowSleepTime = 100
   global $sleepTime = $fastSleepTime

   global $testTimer =  TimerInit()
EndFunc

func pressButton($numTimesToClick)

   navigateToButtonRoom()
   $buttonColor = identifyButtonColor()
   setup()

   for $i = 0 To ($numTimesToClick)-1
	  $globalButtonCounter += 1
	  $repairButton = pixelArraySearch($repairButtonArray, $repairButtonColor)
	  if IsArray($repairButton) = True Then
		 MouseClick("left", $repairButton[0], $repairButton[1],1,1)
		 $sleepTime = $fastSleepTime
		 print("speeding up", 50)
		 sleep(500)
	  EndIf
	  $buttonColor = identifyButtonColor()
	  $buttonPixel = pixelArraySearch($screenCoordsArray, $buttonColor)
	  if ($buttonColor<>-1) Then
		 $bestClickPixel = findBestClick($buttonColor)
		 if (isArray($bestClickPixel)) Then
			MouseClick("left",$bestClickPixel[0], $bestClickPixel[1],1,1)
;~ 			isClickPerfect($bestClickPixel)
		 EndIf
	  EndIf
	  $nearBreak = pixelArraySearch($nearBreakArray, $nearBreakColor)
	  if (IsArray($nearBreak) = True And IsArray($buttonPixel) = True And $sleepTime = $fastSleepTime) Then
		 if ($nearBreak[0]+100 < $buttonPixel[0] Or $nearBreak[0]-100>$buttonPixel[0]) Then
			print("slowing down", 50)
			$sleepTime = $slowSleepTime
			upgradeGrandpas()
		 EndIf
	  EndIf

	  sleep($sleepTime)
   Next
   $numMinutes = getMinutesFromTimerStart($testTimer)
   $buttonsPerMinute = $globalButtonCounter/$numMinutes
EndFunc

func isClickPerfect($clickPosition) ;;under advisement  Takes too long and doesnt always work?
	  sleep(100)
	  local $lastClickColor = PixelGetColor($clickPosition[0]+10, $clickPosition[1]-20)
	  if ($lastClickColor == 26059) Then
		 print("Perfect")
	  EndIf
	  if ($lastClickColor == 16758528 Or $lastClickColor == 16750848) Then
		 print("excellent")
	  EndIf
;~ 	  print($lastClickColor, 100)
EndFunc


func identifyButtonColor()
   Local $nearBreakArray[4]
   $nearBreakArray[0] =551
   $nearBreakArray[1] =407
   $nearBreakArray[2] =930
   $nearBreakArray[3] =515
   Local $normalButtonColor = 0xC86400
   Local $boostedButtonColor =  0x0064C8
   $buttonPixel = PixelSearch($nearBreakArray[0],$nearBreakArray[1],$nearBreakArray[2],$nearBreakArray[3], $normalButtonColor)
   if IsArray($buttonPixel) = True Then
	  return $normalButtonColor
   EndIf
   $buttonPixel = PixelSearch($nearBreakArray[0],$nearBreakArray[1],$nearBreakArray[2],$nearBreakArray[3],$boostedButtonColor)
   if IsArray($buttonPixel) = True Then
	  return $boostedButtonColor
   Else
	  return -1
   EndIf
EndFunc

func findBestClick($buttonColor)
   $topLeftButtonPixel = PixelSearch($buttonCoordsArray[0], $buttonCoordsArray[1], $buttonCoordsArray[2], $buttonCoordsArray[3], $buttonColor)
   $topRightButtonPixel = PixelSearch($buttonCoordsArray[2], $buttonCoordsArray[1], $buttonCoordsArray[0], $buttonCoordsArray[3], $buttonColor)
   $topMiddleButtonPixel = averagePixelLocations($topLeftButtonPixel, $topRightButtonPixel)

   $bottomLeftButtonPixel = PixelSearch($buttonCoordsArray[0], $buttonCoordsArray[3], $buttonCoordsArray[2],  $buttonCoordsArray[1], $buttonColor)
   $bottomRightButtonPixel = PixelSearch($buttonCoordsArray[2], $buttonCoordsArray[3], $buttonCoordsArray[0],  $buttonCoordsArray[1], $buttonColor)
   $bottomMiddleButtonPixel = averagePixelLocations($bottomLeftButtonPixel, $bottomRightButtonPixel)
   $finalButtonPixel = averagePixelLocations($topMiddleButtonPixel, $bottomMiddleButtonPixel)
   return $finalButtonPixel
EndFunc

func averagePixelLocations($firstPixel, $secondPixel)
   if (IsArray($firstPixel) And IsArray($secondPixel)) Then
	  Local $xValue = ($firstPixel[0] + $secondPixel[0]) / 2
	  Local $yValue = ($firstPixel[1] + $secondPixel[1]) / 2
	  Local $averagePixel[2]
	  $averagePixel[0] = $xValue
	  $averagePixel[1] = $yValue
	  return $averagePixel
   EndIf
EndFunc

func upgradeButton()
   ;open shop
   MouseClick("left", 868, 651, 1, 1)
   ;upgrade multiplier
   MouseClick("left", 914, 479, 5, 3)
   ;close shop
   MouseClick("left", 868, 651, 1, 1)
EndFunc

func upgradeGrandpas()
   ;open grandpas
   MouseClick("left", 944, 652, 1, 1)
   ;buy more grandpas
   MouseClick("left", 549, 475, 1, 1)
   ;buy more speed
   MouseClick("left", 731, 474, 1, 1)
   ;buy more accuracy
   MouseClick("left", 838, 481, 1, 1)
   ;buy more discipline
   MouseClick("left", 934, 478, 1, 1)
   ;close grandpas
   MouseClick("left", 944, 652, 1, 1)
EndFunc