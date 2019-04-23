#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=noblegarden\favicon.ico
#AutoIt3Wrapper_Outfile_x64=noblegarden\script.Exe
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=c:\users\logan\desktop\scripts\noblegarden\test1.kxf
$Form1_1 = GUICreate("Noblegarden Collecting Script", 608, 434, 223, 155)
GUISetBkColor(0x0000FF)
$changeOpen = GUICtrlCreateInput("5", 8, 96, 73, 33)
GUICtrlSetFont(-1, 16, 400, 0, "MS Sans Serif")
$guideLabel = GUICtrlCreateLabel("", 40, 328, 528, 85)
GUICtrlSetFont(-1, 16, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xA6CAF0)
$titleLabel = GUICtrlCreateLabel("Welcome to Logan's Noblegarden Script", 16, 16, 579, 41)
GUICtrlSetFont(-1, 24, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFF80)
$openEgg = GUICtrlCreateLabel("Open Egg Keybind: ", 8, 64, 181, 29)
GUICtrlSetFont(-1, 16, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFF80)
$submitOpen = GUICtrlCreateButton("Submit", 88, 96, 83, 33)
GUICtrlSetFont(-1, 16, 400, 0, "MS Sans Serif")
$listBG = GUICtrlCreateGraphic(208, 96, 329, 201)
GUICtrlSetColor(-1, 0x000040)
GUICtrlSetBkColor(-1, 0xA6CAF0)
$listHeadLabel = GUICtrlCreateLabel("Your current stored egg points: ", 208, 64, 275, 29)
GUICtrlSetFont(-1, 16, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFF80)
$resetButton = GUICtrlCreateButton("Reset Nodes", 8, 136, 139, 41)
GUICtrlSetFont(-1, 16, 400, 0, "MS Sans Serif")
$runButton = GUICtrlCreateButton("Run", 8, 184, 139, 41)
GUICtrlSetFont(-1, 24, 400, 0, "MS Sans Serif")
$guideBG = GUICtrlCreateGraphic(24, 320, 553, 97)
GUICtrlSetColor(-1, 0x000040)
GUICtrlSetBkColor(-1, 0xA6CAF0)
$listLabel = GUICtrlCreateLabel("Ctrl + Space to set point", 224, 102, 160, 180)
GUICtrlSetFont(-1, 24, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xA6CAF0)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

HotKeySet("^{SPACE}", 'addPoint')
HotKeySet('^+{SPACE}', 'runScript')
GUICtrlSetData($guideLabel, "Ctrl + Space to add current mouse position as point            Ctrl + Shift + Space to run or stop script.                                    Create a macro to use the egg and then configure.")

Global $totalPoints = 5
Global $openMacro = "5"
Global $running = False
Global $points[$totalPoints][2]
Global $pointsUsed = 0

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $submitOpen
			changeMacro()
		Case $resetButton
			resetPoints()
		Case $runButton
			runScript()
	EndSwitch
WEnd

Func changeMacro()
	$openMacro = GUICtrlRead($changeOpen)
EndFunc   ;==>changeMacro

Func addPoint()
	If ($pointsUsed < $totalPoints) Then
		$points[$pointsUsed][0] = MouseGetPos(0)
		$points[$pointsUsed][1] = MouseGetPos(1)
		$pointsUsed = $pointsUsed + 1
		$string = ""
		For $i = 0 To $pointsUsed - 1 Step 1
			$string = $string & String($points[$i][0]) & ":" & String($points[$i][1]) & " "
		Next
		GUICtrlSetData($listLabel, $string)
	Else
		MsgBox(1, "Point Overflow", "This script is currently configured for " & $totalPoints & " points.")
	EndIf
EndFunc   ;==>addPoint

Func resetPoints()
	$pointsUsed = 0
	GUICtrlSetData($listLabel, "")
EndFunc   ;==>resetPoints

Func runScript()
	$running = Not $running
	If $running Then
		main()
	EndIf
EndFunc   ;==>runScript

Func main()
	While $running
		$random = Random(0, 200)
		Opt("SendKeyDownDelay", $random)
		For $i = 0 To $pointsUsed - 1 Step 1
			If Not $running Then
				ExitLoop
			EndIf
			MouseClick('left', $points[$i][0], $points[$i][1])
			Sleep(1300 + $random)
		Next
		Send($openMacro)
		Sleep(300 + $random)
	WEnd
EndFunc   ;==>main



