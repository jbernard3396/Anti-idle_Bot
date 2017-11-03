#include-once
func stadium($iters)
   ;go to Stadium screen
   $count = 0
   MouseMove(953, 331)
   sleep(500)
   MouseClick("left",946, 512, 1, 5)
   sleep(100)
   ;click on Bet
   MouseClick("left", 532, 571,1, 5)
   while ($count<$iters)
	  ;increase Coins
	  MouseClick("left", 795, 530,5,5)
	  ;increase Tokens
	  MouseClick("left", 797, 564,5,5)
	  ;bet on Red
	  MouseClick("left", 673, 473, 1, 5)
	  sleep(100)
	  if (PixelGetColor(699, 505) = 0xD0D04F) Then
		 $count = $iters
	  EndIF
	  ;wait for race to end
	  houseKeeping()
	  sleep(15000)
	  ;back to menu
	  MouseClick("left", 728, 624, 1, 5)
	  $count=$count+1
	  $globalBetCounter=$globalBetCounter+1
   Wend
EndFunc
