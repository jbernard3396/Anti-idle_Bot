;;Anti-Idle Bot
#include-once
#include <MsgBoxConstants.au3>
#include <C:\Users\jbern\Documents\Bots\UsefulInclude.au3>
#include <Color.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <CenterScreen.au3>
#include <ButtonPresser.au3>
#include <Battlebot.au3>
#include <FishingBot.au3>
#include <ArcadeBot.au3>
#include <StadiumBot.au3>
#include <MajorHouseKeepingBot.au3>
#include <MinorHouseKeepingBot.au3>
#include <OtherBot.au3>

Opt("MouseClickDownDelay", 10)
Opt("SendKeyDelay", 50)
Opt("SendKeyDownDelay", 50)


HotKeySet("{TAB}", toggleOptions)
HotKeySet("{BS}" , toggleIdle)
HotKeySet("{DEL}", showQuest)

;globals
local $globalBatlleCounter =0
Local $globalButtonCounter= 0
Local $globalFishingCounter = 0
Local $globalWAGCounter = 0
Local $globalBetCounter = 0

Local $exitInfo = "Done"

$scrl = (476)
$scrt = (247)
$scrr = (1123)
$scrb = (911)

Local $screenCoordsArray[4]
$screenCoordsArray[0] = $scrl
$screenCoordsArray[1] = $scrt
$screenCoordsArray[2] = $scrr
$screenCoordsArray[3] = $scrb


;create plant new garden array
Local $seedLoc[2]
$seedLoc[0] = 545
$seedLoc[1] = 375
Local $incrementSize = 30


MainLoop()
;~ centerScreenForAntiIdle()
;~ WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
;adventure()
;manageCyborg()
;~ openBoxes()
;~ Arcade(True)
;~ playAvoid()
;~    playBalance()
;~ pressButton(250000)
;~ Battle(10)
;~ stadium(10)
;~ majorHouseKeeping1()
;~ majorHouseKeeping2()
;handlePet()

Func MainLoop()
   WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
   centerScreenForAntiIdle()
   ;forfeitQuest()
   while 1
	  HouseKeeping()
	  majorHouseKeeping1()
	  majorHouseKeeping2()
	  $numIters = Random(500,500, 1)
	  $option = Random(0 ,8, 1)
	  if ($option = 0) Then
		 pressButton($numIters)
	  ElseIf($option <= 5 ) Then
;~ 		 Battle($numIters)
	  ElseIf($option <= 6) Then
;~ 		 fishing($numIters)
	  ElseIf($option <= 7) Then
;~ 		 Arcade(True)
	  ElseIf($option <= 8) Then
;~ 		 stadium($numIters)
	  EndIf
	  $exitInfo = "fishing: " & $globalFishingCounter & "  " & "Battle: " & $globalBatlleCounter & "  " & "Button: " & $globalButtonCounter & " " & "WAG: " & $globalWAGCounter & " Bets: " & $globalBetCounter
   WEnd
EndFunc