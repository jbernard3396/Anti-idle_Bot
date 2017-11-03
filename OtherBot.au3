#include-once
;other
;HotKeyHelper
func toggleOptions()
   ;open options
   MouseClick("left", 687, 877, 1, 10)
   ;toggle options
   MouseClick("left", 495, 432, 1, 10)
   ;dont wanna toggle ants/boosts
   ;MouseClick("left", 494, 445, 1, 10)
   MouseClick("left", 496, 462, 1, 10)
   MouseClick("left", 496, 477, 1, 10)
   MouseClick("left", 495, 492, 1, 10)
   MouseClick("left", 492, 506, 1, 10)
   MouseClick("left", 494, 522, 1, 10)
   MouseClick("left", 495, 536, 1, 10)
   MouseClick("left", 495, 554, 1, 10)
   MouseClick("left", 495, 566, 1, 10)
   ;close options
    MouseClick("left", 687, 877, 1, 10)
EndFunc

func toggleIdle()
   MouseClick("left", 1056, 616, 1, 5)
EndFunc

func showQuest()
   ;open quest menu
   MouseClick("left", 637, 840, 1, 5)
   ;select random quests
   MouseClick("left", 870, 333, 1, 5)
   ;let user read
   sleep(3000)
   ;close
   MouseClick("left", 1115, 333, 1, 5)
EndFunc

;unused helper
func forfeitQuest()
   ;open quests
   MouseClick("left", 638, 838, 1, 2)
   ;open random quests
   MouseClick("left", 859, 332, 1, 2)
   ;attempt to complete quest
   MouseClick("left", 599, 619, 1, 2)
   ;attempt to forfeit Quest
   send("{SHIFTDOWN}")
   MouseClick("left", 599, 649, 1, 2)
   send("{SHIFTUP}")
   ;close quests
   MouseClick("left", 638, 838, 1, 2)
EndFunc

func writeDay()
   $File = "C:\Users\jbern\Documents\Bots\testFile.txt"
   FW($File, @MDAY, 0)
EndFunc

func readDay()
   $File = "C:\Users\jbern\Documents\Bots\testFile.txt"

   if (FR($File) = @MDAY) Then
	  print ("true")
   Else
	  writeDay()
	  print("false")
   EndIf
EndFunc