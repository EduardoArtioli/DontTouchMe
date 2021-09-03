#include <BlockInputEx.au3>
#include <GUIConstantsEx.au3>
#include <FontConstants.au3>

HotKeySet("{F9}", "_Terminate")

;~ #include <Misc.au3>
;~ #include <MsgBoxConstants.au3>
;~ #include <WindowsConstants.au3>





Global $Notepad_Open = "0"
Global $hNotepad_Wnd
Local $Counter

$strComputer = "."
$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\CIMV2")

;_BlockInputEx(1, "", "")

Func _Terminate()
	Exit
EndFunc

Func _OpenNotepad()
   If $Notepad_Open = "0" Then

		Run("C:\Program Files\Notepad++\notepad++.exe", "", @SW_MAXIMIZE)
		WinWait("[CLASS:Notepad++]","",5)
		Sleep(1000)
		Send("{F12}")
		;~ ControlSetText($hNotepad_Wnd, "", "", _
		;~ 	"Now try to input some keys in here..." & @CRLF & _
		;~ 	"Well, that's the idea, you can't, don't you?" & @CRLF & @CRLF & ":)")

		$Notepad_Open = "1"
   EndIf
EndFunc

Func _scrollDown()
	If $Notepad_Open = "1" Then
		If $Counter = 25 Then
			MouseWheel("down",1)
			$Counter = 0
		Else
			$Counter = $Counter + 1
		EndIf
	EndIf
EndFunc

Func _checkUSB()
	If $Counter = 25 Then
		$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_PnPEntity where DeviceID like 'USB\\%'")
		If IsObj($colItems) then
			For $objItem In $colItems
				If $objItem.Caption ==  "D-Link DWA-131 Wireless N Nano USB Adapter" Then
					_Terminate()
				EndIf
			Next
		Endif
		$Counter = 0
	Else
		$Counter = $Counter + 1
	EndIf
EndFunc

Func _CreateGUI()
    Local $hGUI = GUICreate("Boo!",@DesktopWidth,@DesktopHeight,0,0,$WS_POPUP)
    Local $idOK = GUICtrlCreateButton("Boo!", 310, 370, 85, 25)
	GUISetBkColor(0x000000)

    GUICtrlCreateLabel("AUAUAUAUAUUAUAUAUAUAUAU 1 Cell 1", 0, 0, @DesktopWidth,@DesktopHeight)
    GUICtrlSetColor(-1, 0x00FF40) ; will change text color for specified control

    Local Const $sFont = "Consolas"

    GUICtrlCreateLabel("AUAUAUAUAUUAUAUAUAUAUAU 1 Cell 1", 70, 80, @DesktopWidth,@DesktopHeight)
    GUICtrlSetFont(-1, 20, $FW_NORMAL, $GUI_FONTUNDER, $sFont,5) ; Set the font of the previous control.
    GUICtrlSetColor(-1, 0x00FF40) ; will change text color for specified control

    GUICtrlCreateLabel("AUAUAUAUAUUAUAUAUAUAUAU 1 Cell 1", 200, 200, @DesktopWidth,@DesktopHeight)
    GUICtrlSetFont(-1, 12, $FW_NORMAL,  $GUI_FONTITALIC, $sFont,5) ; Set the font of the controlID stored in $iLabel2.
    GUICtrlSetColor(-1, 0x00FF40) ; will change text color for specified control

    GUICtrlCreateLabel("AUAUAUAUAUUAUAUAUAUAUAU 1 Cell 1",500, 500, @DesktopWidth,@DesktopHeight)
    GUICtrlSetFont(-1, 9, $FW_NORMAL, $GUI_FONTSTRIKE, $sFont,5) ; Set the font of the controlID stored in $iLabel3.
    GUICtrlSetColor(-1, 0x00FF40) ; will change text color for specified control

    GUISetState(@SW_SHOW, $hGUI)

    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE, $idOK
                ExitLoop

        EndSwitch
    WEnd
    GUIDelete($hGUI)
EndFunc

_CreateGUI()
_main()
Func _main()

	;~ _MouseTrap( 0, 0, 1, 1 )
	BlockInput(1)

	while 1

		if _IsPressed(01) Then
			_OpenNotepad()
			If $Notepad_Open = "1" Then
			BlockInput(1)
			_MouseTrap( 0, 0, 0, 0 )
			EndIf
		endif

		If ProcessExists( "taskmgr.exe" ) Then
			ProcessClose( "taskmgr.exe" )
			BlockInput(1)
			_MouseTrap( 0, 0, 0, 0 )
		 EndIf

	  	_scrollDown()
		_checkUSB()
		sleep(1)
	Wend
EndFunc

;~ _BlockInputEx(3, "", _
;~ 		"{ALT}|{DEL}|{HOME}|{ESCAPE}|{ESC}|{BREAK}|{PAUSE}|{BREAK}|" 		& _
;~ 		"{APPSKEY}|{LALT}|{RALT}|{LCTRL}|{RCTRL}|{LSHIFT}|{RSHIFT}|"		& _
;~ 		"{SLEEP}|{ALTDOWN}|{SHIFTDOWN}|{CTRLDOWN}|{LWINDOWN}|{LSHIFT}|"		& _
;~ 		"{SLEEP}|{ALTDOWN}|{SHIFTDOWN}|{CTRLDOWN}|{LWINDOWN}|{RWINDOWN}|"	& _
;~ 		"{TAB}|{LWIN}|{RWIN}|{BACKSPACE}|{UP}|{DOWN}|{LEFT}|{RIGHT}" _
;~ 	)