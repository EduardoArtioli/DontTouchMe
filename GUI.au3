#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <FontConstants.au3>
#include <APIGdiConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>

HotKeySet("{ESC}", "_Terminate")

Global $iLine
Global $buffer
Global $file = FileOpen("hmm")

Global $Lines
While 1
    ; Read in the next line - it will start with the first automatically
    $Lines_Checker = FileReadLine($file)
    ; Check if we have run out of lines and exit the loop if we have
    If @error = -1 Then ExitLoop
    ; Then for each line:
	  $Lines += 1
    ; "Series of things i would like to do"

WEnd

Func _Terminate()
	Exit
 EndFunc

$iSuccess = _WinAPI_AddFontResourceEx(@ScriptDir&"\monaco.ttf", $FR_PRIVATE,False)
If $iSuccess=0 Then Exit MsgBox(0, "", "Font did not load successfully")


_CreateGUI()
Func _CreateGUI()
   Local $hGUI = GUICreate("Boo!",@DesktopWidth,@DesktopHeight,0,0,$WS_POPUP)
   GUISetBkColor(0x000000)

   Local Const $sFont = "monaco"
   Local $Input1 = GUICtrlCreateLabel("", 100, 0, @DesktopWidth,@DesktopHeight)
   GUICtrlSetFont(-1, 15, 0, 0, $sFont,0)
   GUICtrlSetColor(-1, 0x00FF40)
   GUISetState(@SW_SHOW, $hGUI)

   While 1
	  $Lines -= 1
	  ConsoleWrite($Lines)
	  $sFileRead = FileReadLine($file, $Lines)
	  $buffer = $sFileRead & @CRLF
	  GUICtrlSetData($Input1,$buffer&GUICtrlRead($Input1))
	  Sleep(150)

   WEnd
    FileClose($file)
EndFunc