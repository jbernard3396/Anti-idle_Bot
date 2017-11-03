#include-once
;;major housekeeping1 helpers
func plantTrees()
   plantGarden()
;~    plantNewGarden()
EndFunc

func plantGarden()
   ;go to gardening screen
   MouseMove(953, 331)
   sleep(500)
   MouseClick("left",938, 383, 1, 5)
   sleep(100)
   ;close menu
   MouseMove(500,500, 10)
   ;buy more plots
   MouseClick("left",971, 439, 10, 5)
   Local $tree = 720
   for $i = 0 To 7
	  MouseClick("left",720-(30*$i), 647, 1, 2)
	  MouseClick("left", 831, 652, 1, 2)
   Next

;~    ;fertalise
;~    if(Random(0,1,1) = 0) Then  ;;TODO fix this
;~ 	  MouseMove(504, 430)
;~ 	  sleep(100)
;~ 	  MouseClick("left", 520, 430, 1,10)
;~    EndIF
   ;switch to new garden
   MouseClick("left", 603, 548, 1, 10)
   MouseClick("left", 500, 500, 1, 10)
EndFunc

func plantNewGarden()
   ;$seedSelect = Random(100,200, 1)
   MouseClick("left",971, 439, 10, 5)
   for $i = 0 To 15
	  for $j = 0 To 5
		 MouseClick("left", 541, 657, 1, 1)
		 MouseClick("left",$seedLoc[0]+($incrementSize*$i), $seedLoc[1] +($incrementSize*$j), 1, 1)
		 MouseClick("left", 829, 655, 1, 1)
	  Next
   Next
   ;close select seed
   MouseClick("left", 499, 336)

   ;fertalise
   MouseMove(504, 430)
   sleep(100)
   MouseClick("left", 520, 430, 1,10)

EndFunc

func upgradePrinter()
   MouseMove(953, 331)
   sleep(500)
   MouseClick("left",949, 464, 1, 5)
   sleep(100)
   ;close menu
   MouseMove(500,500, 10)
   MouseClick("left", 967, 431, 30, 1)
EndFunc

func adventure()
   Local $noAdventureColor = 0x656333
   Local $AdventureLocation[2]
   $AdventureLocation[0] = 642
   $AdventureLocation[1] = 802
   ;navigate to adventure screen
   ;openmenu
   MouseMove(953, 331)
   sleep(500)
   ;click Adventure
   MouseClick("left",934, 585, 1, 5)
   sleep(100)
   ;close menu
   MouseMove(700, 500)
   $count = 0
   while (PixelGetColor($AdventureLocation[0], $AdventureLocation[1]) <> $noAdventureColor And $count<25)
	  $shouldMore = Random(0,10,1)
	  if ($shouldMore = 0) Then
		 MouseClick("left", 578, 536, 1, 1)
	  EndIf
	  $count = $count +1
	  MouseClick("left", 664, 500, 1, 1)
	  sleep(100)
	  MouseClick("left", 661, 524, 1, 1)
	  sleep(100)
	  MouseClick("left", 660, 547, 1, 1)
	  sleep(100)
	  MouseClick("left", 680, 570, 1, 1)
	  sleep(100)
   WEnd
EndFunc

func completeRandomQuests()
   ;open quests
   MouseClick("left", 638, 838, 1, 1)
   ;open random quests
   MouseClick("left", 859, 332, 1, 3)
   ;attempt to complete quest
   MouseClick("left", 599, 619, 1, 3)
   ;close quests
   MouseClick("left", 638, 838, 1, 1)
EndFunc

func acceptDailyQuests()

   Local $questLoc[2]
   $questLoc[0] = 580
   $questLoc[1] = 355

   ;open quests
   MouseClick("left", 630, 840, 1, 1)
   ;open mainQuests
   MouseClick("left", 776, 331)
   ;flip to first page
   MouseClick("left", 555, 774, 10, 3)

   ;accept Quests
   for $i = 0 To 19
	  MouseClick("left", $questLoc[0], $questLoc[1] + ($i*20), 1, 1)
	  MouseClick("left", 1044, 635, 5, 1)
   Next
   ;close quests
   MouseClick("left", 638, 838, 1, 1)
EndFunc

func upgradeProgressBar($uGC, $uBC, $uES)
   Local $shouldDo = Random(0,1000,1)
   if ($shouldDo > 0) Then
	  $uGC = False
	  $uBC = False
	  $uES = False
   EndIf
   ;open upgrade screen
   MouseClick("left", 1052, 503, 1, 3)
   ;spend green coins to upgrade idleMode
   if ($uGC = True) Then
	  MouseClick("left", 838, 405, 5, 3)
   EndIf
   ;spend blue coind to upgrade anti-idlemode
   if ($uBC = True) Then
	  MouseClick("left", 839, 433, 5, 3)
   EndIf
   ;spend gold coins to but epic skills (must unlock in shop first
   if ($uES = True) Then
	  ;click on every option
	  for $i = 0 To 6
		 MouseClick("left", 605+(65*$i), 551, 1, 1)
	  Next



   EndIf
    ;close
   MouseClick("left", 1115, 332, 1, 1)
EndFunc

func handlePet()
   ;open Pet menu
   MouseClick("left", 797, 876, 1, 3)
   sleep(100)
   ;check if pet is hungry
   if (isPetHungry() = true) Then
	  ;pet is hungry, feed
	  MouseClick("left", 1049, 793, 1, 10)
   EndIf
   ;attempt to spend mana
   MouseClick("left", 916, 388, 1, 1)
   ;close menu
   MouseClick("left", 1116, 330, 1, 1)
EndFunc

func isPetHungry()
   ;NEEDs to be called from open pet menu
   ;still needs to be checked on hungry pet

   Local $fullColor = 0x645F24
   Local $emptyLoc[2]
   $emptyLoc[0] = 672
   $emptyLoc[1] = 429



   ;check fullness
   if (PixelGetColor($emptyLoc[0], $emptyLoc[1]) = $fullColor) Then
	  print("full")
	  WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
	  return(False)
   Else
	  print("hungry", 1000)
	  WinActivate("Play Anti-Idle: The Game, a free online game on Kongregate")
	  return(True)
   EndIf



EndFunc

func openBoxes()
   $shouldOpen = Random(0,0,1)
   Local $firstBox[2]
   $firstBox[0] = 540
   $firstBox[1] = 400
   Local $distanceLeft = 95
   Local $distanceDown = 95
   if ($shouldOpen = 0) Then
	  ;go to Box screen
	  MouseMove(953, 331)
	  sleep(500)
	  ;scroll to bottom
	  MouseMove(957, 663)
	  sleep(500)
	  ;click on open boxes
	  MouseClick("left",938, 587, 1, 5)
	  sleep(100)
	  ;open 1 of each box
	  for $i = 0 To 4
		 for $j = 0 To 1
			MouseClick("left", $firstBox[0]+($i*$distanceLeft), $firstBox[1]+($j*$distanceDown),1,3)
		 Next
	  Next
   EndIf
EndFunc

func majorHouseKeeping1()
;~    plantTrees()
;~    upgradePrinter()
;~    adventure()
;~    completeRandomQuests()
;~    acceptDailyQuests()
;~    upgradeProgressBar(True, False, False)
;~    openBoxes()
;~    handlePet()
EndFunc


;helpers for majorHouseKeeping2
;created a second one to reduce testing time

func manageCyborg()
   Local $isInactiveColor = 0x252525
   local $RechargeLoc[2]
   $RechargeLoc[0] = 500
   $RechargeLoc[1] = 500
   Local $moveLeft = 205
   Local $moveDown = 45
   ;open cyborg screen
   MouseClick("left", 859, 878, 1, 5)
   sleep(100)
   if(PixelGetColor(665, 498) <> $isInactiveColor) Then
	  $randomX = Random(0,2,1)
	  $randomY = Random(0,6,1)
	  if (($randomX = 0) And ($randomY = 0)) Then
		 ;do nothing
	  Else
		 ;select skill
		 MouseClick("left", $RechargeLoc[0]+($randomX*$moveLeft), $RechargeLoc[1]+($randomY*$moveDown))
		 ;click start
		 MouseClick("left", 743, 609, 1, 5)
	  EndIf

   EndIf
   ;close cyborg screen
   MouseClick("left", 859, 878, 1, 5)
EndFunc

func buyFertilizer()
   ;click on shop
   MouseClick("left", 1024, 841, 1, 4)
   ;click on Mystery shop
   MouseClick("left", 941, 336, 1, 3)
   ;click on buy fertilizer
   MouseClick("left", 1092, 581, 1, 3)
   ;click buy
   MouseClick("left", 752, 619,1,3)
   ;click cancel incase out of cash
   MouseClick("left", 846, 616, 1, 3)
   ;close shop
   MouseClick("left", 1113, 332,1,3)
EndFunc

func buyMaxBoosts()
   ;open boosts screen
   MouseClick("left", 1021, 715, 1, 4)
   ;buy max boosts
   MouseClick("left", 796, 666,1,5)
   ;close boosts screen
   MouseClick("left", 1021, 715, 1, 4)
EndFunc

func majorHouseKeeping2()
;~    manageCyborg()
;~    buyFertilizer()
;~    buyMaxBoosts()
EndFunc