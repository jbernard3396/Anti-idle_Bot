;battle helpers
#include-once

;battle helpers
func Battle($iters)
   Local $fightLvl = 10
   $fightLocation = chooseFightLocation($fightLvl)
   ;openmenu
   MouseMove(953, 331)
   sleep(500)
   ;click battle arena
   MouseClick("left",947, 400, 1, 5)
   sleep(100)
   ;open Map
   MouseClick("left", 826, 656, 1, 5)
   MouseClick("left", $fightLocation[0], $fightLocation[1], 1, 5)
   ;closeMap
   ;MouseClick("left",495, 332, 1, 10)
   ;sleep(100)
  ; MouseClick("left",495, 332, 1, 10)
   Local $count = 0
   ;atLocation to fight
   for $i = 0 To ($iters/5)
	  $globalBatlleCounter = $globalBatlleCounter +1
	  $count = $count + 1
	  if $count >= 30 Then
		 houseKeeping()
		 $count = 0
	  EndIf
	  battleBasic()
	  battleHeal()
   Next
   finishMissionKommanders()
EndFunc

func chooseFightLocation($fightLevel)
   Local $battleArenaArray[16][6]
   for $i = 0 To 15
	  for $j = 0 To 5
		 $battleArenaArray[$i][$j] = -1
	  Next
   Next
   $battleArenaArray[1][2] = 1
   $battleArenaArray[2][2] = 2
   $battleArenaArray[3][2] = 3
   $battleArenaArray[4][2] = 4
   $battleArenaArray[5][2] = 5
   $battleArenaArray[5][1] = 6
   $battleArenaArray[6][2] = 6
   $battleArenaArray[7][2] = 0
   $battleArenaArray[8][2] = 8
   $battleArenaArray[9][2] = 9
   $battleArenaArray[10][2] = 10
   $battleArenaArray[11][2] = 11
   $battleArenaArray[12][2] = 12
   $battleArenaArray[13][2] = 13
   $battleArenaArray[14][2] = 0
   $battleArenaArray[15][2] = 15
   Local $origin[2]
   $origin[0] = 500
   $origin[1] = 338

   Local $fightAt[2]
   $fightAt[0] = -1
   $fightAt[1]=-1
   while $fightAt[0] = -1
	  $randLoc = random(1,15, 1)
	  if ($battleArenaArray[$randLoc][2] >0 AND $battleArenaArray[$randLoc][2] <=$fightLevel) Then
		 $fightAt[0]=$randLoc
		 $fightAt[1]=2
	  EndIF
   WEnd
   local $fightCoords[2]
   $fightCoords[0] = $origin[0] + ($fightAt[0]*30)
   $fightCoords[1] = $origin[1] + (30*$fightAt[1])
   WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
   return $fightCoords

EndFunc

;;helper function for arena
func battleBasic()
   MouseClick("left", 571, 653, 1,5)
   sleep(400)
EndFunc

func battleHeal()
    MouseClick("left", 579, 617, 1,5)
   sleep(800)
EndFunc

func finishMissionKommanders()
   ;;MissionKommander
   ;open Map
   MouseClick("left", 826, 656, 1, 5)
   ;go to pub
   MouseClick("left", 505, 402, 1, 5)
   ;open commander menu
   MouseClick("left", 737, 404, 1, 5)
   ;finish Quest
   MouseClick("left", 909, 444, 1, 5)
   ;close menu
   MouseClick("left", 738, 502, 1, 5)


   ;;BattleMaster
   ;open Map
   MouseClick("left", 826, 656, 1, 5)
   ;go to advanced battle arena
   MouseClick("left",566, 402, 1, 5)
   ;open master menu
   MouseClick("left", 676, 392, 1, 5)
   ;next reward
   MouseClick("left", 833, 450, 1, 5)
   ;dailyReward
   MouseClick("left", 826, 468, 1, 5)
   ;close menu
   MouseClick("left", 932, 508, 1, 5)
EndFunc