#include-once
#include <./Helpers/BattleMapHelpers.au3>


func Battle($iters)
   battleBotSetup()
   Local $count = 0
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

func battleBotSetup()
   Local $fightLvl = 10
   $fightLocation = chooseFightLocation($fightLvl)
   MouseMove(953, 337) ;open menu
   sleep(500)
   MouseClick("left",947, 405, 1, 5)    ;click battle arena
   sleep(100)
   MouseClick("left", 826, 656, 1, 5)    ;open Map
   MouseClick("left", $fightLocation[0], $fightLocation[1], 1, 5)  ;go to location
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

