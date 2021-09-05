#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <FontConstants.au3>
#include <APIGdiConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
HotKeySet("{F9}", "_Terminate")


Global $file = FileOpen("hmm.txt")
Func _Terminate()
	Exit
 EndFunc

$iSuccess = _WinAPI_AddFontResourceEx(@ScriptDir&"\monaco.ttf", $FR_PRIVATE,False)
If $iSuccess=0 Then Exit MsgBox(0, "", "Font did not load successfully")

Func _CreateGUI()
    Local $hGUI = GUICreate("Boo!",@DesktopWidth,@DesktopHeight,0,0,$WS_POPUP)
    Local $idOK = GUICtrlCreateButton("Boo!", 310, 370, 85, 25)
	GUISetBkColor(0x000000)

    Local Const $sFont = "monaco"
    Local $Input1 = GUICtrlCreateLabel(FileRead($file, 9000), 100, 0, @DesktopWidth,@DesktopHeight)
    GUICtrlSetFont(-1, 10, 0, 0, $sFont,0) ; Set the font of the controlID stored in $iLabel3.
    GUICtrlSetColor(-1, 0x00FF40) ; will change text color for specified control

    FileClose("hmm.txt")


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