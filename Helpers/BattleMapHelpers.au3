#include-once
func chooseFightLocation($fightLevel)
   Local $battleArenaArray[16][6]
   for $i = 0 To 15
	  for $j = 0 To 5
		 $battleArenaArray[$i][$j] = -1
	  Next
   Next
   $battleArenaArray[1][2] = 1 ;Beginner training zone
   $battleArenaArray[2][0] = 2 ;The Special Arena
   $battleArenaArray[2][2] = 2 ;Advanced training zone
   $battleArenaArray[3][2] = 3 ;Mystic Forest
   $battleArenaArray[4][2] = 4 ;Night Forest
   $battleArenaArray[5][1] = 6 ;Polluted Sky
   $battleArenaArray[5][2] = 5 ;The Sky
   $battleArenaArray[6][2] = 6 ;The Deadlands
   $battleArenaArray[7][2] = 0 ;Dangerzone
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
	  if($battleArenaArray[$randLoc][2] > 0 AND $battleArenaArray[$randLoc][2] <= $fightLevel) Then
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

Func updateFightLevel()

EndFunc