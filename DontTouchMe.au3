#include <BlockInputEx.au3>

HotKeySet("{F9}", "_Terminate")

;~ #include <Misc.au3>
;~ #include <MsgBoxConstants.au3>
;~ #include <WindowsConstants.au3>



Global $Notepad_Open = "0"
Global $hNotepad_Wnd

$strComputer = "."
$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\CIMV2")


;~ _BlockInputEx(1, "", "")

;~ _BlockInputEx(3, "", _
;~ 		"{ALT}|{DEL}|{HOME}|{ESCAPE}|{ESC}|{BREAK}|{PAUSE}|{BREAK}|" 		& _
;~ 		"{APPSKEY}|{LALT}|{RALT}|{LCTRL}|{RCTRL}|{LSHIFT}|{RSHIFT}|"		& _
;~ 		"{SLEEP}|{ALTDOWN}|{SHIFTDOWN}|{CTRLDOWN}|{LWINDOWN}|{LSHIFT}|"		& _
;~ 		"{SLEEP}|{ALTDOWN}|{SHIFTDOWN}|{CTRLDOWN}|{LWINDOWN}|{RWINDOWN}|"	& _
;~ 		"{TAB}|{LWIN}|{RWIN}|{BACKSPACE}|{UP}|{DOWN}|{LEFT}|{RIGHT}" _
;~ 	)

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

Local $Counter
Func _scrollDown()

	If $Counter = 25 Then
		MouseWheel("down",1)
		$Counter = 0
		_checkUSB()
	Else
		$Counter = $Counter + 1
	EndIf

EndFunc

Func _checkUSB()
	$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_PnPEntity where DeviceID like 'USB\\%'")
	If IsObj($colItems) then
		For $objItem In $colItems
			If $objItem.Caption ==  "D-Link DWA-131 Wireless N Nano USB Adapter" Then
				_Terminate()
			EndIf
		Next
	Endif
EndFunc

_main()
Func _main()

	_MouseTrap( 0, 0, 1, 1 )
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
		sleep(1)
	Wend
EndFunc
