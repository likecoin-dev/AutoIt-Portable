#NoTrayIcon
#AutoIt3Wrapper_Icon=AIP\Icon.ico
#AutoIt3Wrapper_Res_Description=Compile your AutoIt scripts on the fly!
#AutoIt3Wrapper_Res_Fileversion=0.0.1
#AutoIt3Wrapper_Res_LegalCopyright=Copyright 2014 zelles
#AutoIt3Wrapper_Res_Language=1033
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <File.au3>
#include <GUIConstantsEx.au3>
#include <Misc.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>


#Region Begin Startup Settings
_Singleton("AutoItPortableByzelles")
Opt("GUIOnEventMode", 1)
Opt("TrayMenuMode", 3)
#EndRegion End Startup Settings


#Region Begin Startup Globals
Global $DIR_complier_output = @ScriptDir & "\compiled"
Global $DIR_TEMP = @ScriptDir & "\temp_appdata"
Global $DIR_includes = $DIR_TEMP & "\includes"
Global $FILE_icon = $DIR_TEMP & "\Icon.ico"
Global $FILE_TEMP = $DIR_includes & "\aip_temp.au3"
Global $FILE_TEMP_EXE = $DIR_TEMP & "\aip_temp.exe"
Global $IMG_Splash = $DIR_TEMP & "\splash.gif"
Global $Last_Opened = "AIPScript.au3"
#EndRegion End Startup Globals


#Region Begin Startup Functions
GUI_Splash()
Create_Temp_Workstation()
GUIDelete($GUI_Splash)
GUI_Workstation()
#EndRegion End Startup Functions


#Region Begin Idle Loop To Keep Program Alive
While 1
	Sleep(100)
WEnd
#EndRegion End Idle Loop To Keep Program Alive


#Region Begin Splash GUI Creation
Func GUI_Splash()
	If Not FileExists($DIR_TEMP) Then DirCreate($DIR_TEMP)
	FileInstall("C:\AIP\splash.gif", $DIR_TEMP & "\splash.gif", 0)
	Global $GUI_Splash = GUICreate("Starting AutoIt Portable", 401, 257, 192, 124)
	GUISetBkColor(0xFFFFFF)
	Global $splash_image = GUICtrlCreatePic($IMG_Splash, 0, 0, 400, 250)
	GUISetOnEvent($GUI_EVENT_MINIMIZE, "Close_Spash", $GUI_Splash)
	GUISetOnEvent($GUI_EVENT_CLOSE, "Close_Spash", $GUI_Splash)
	GUISetState(@SW_SHOW)
EndFunc
#EndRegion End Splash GUI Creation


#Region Begin Workstation GUI Creation
Func GUI_Workstation()
	Global $GUI_Workstation = GUICreate("AutoIt Portable Workstation", 701, 431, 174, 115)
	Global $File_Menu_File = GUICtrlCreateMenu("&File")
	Global $File_Menu_New = GUICtrlCreateMenuItem("New File", $File_Menu_File)
	Global $File_Menu_Open = GUICtrlCreateMenuItem("Open File", $File_Menu_File)
	Global $File_Menu_Save = GUICtrlCreateMenuItem("Save File", $File_Menu_File)
	Global $File_Menu_Exit = GUICtrlCreateMenuItem("Exit", $File_Menu_File)
	Global $File_Menu_Options = GUICtrlCreateMenu("&Script Options")
	Global $File_Menu_Runx86 = GUICtrlCreateMenuItem("Run x86", $File_Menu_Options)
	Global $File_Menu_Runx64 = GUICtrlCreateMenuItem("Run x64", $File_Menu_Options)
	Global $File_Menu_Compiler = GUICtrlCreateMenuItem("Run Compiler", $File_Menu_Options)
	Global $File_Menu_Help = GUICtrlCreateMenu("&Help")
	Global $File_Menu_About = GUICtrlCreateMenuItem("About", $File_Menu_Help)
	Global $GUI_Workstation_WorkArea = GUICtrlCreateEdit('MsgBox(0, "Welcome Note:", "Thank you for using AutoIt Portable!")', 0, 0, 700, 409, BitOR($ES_AUTOVSCROLL,$ES_WANTRETURN,$WS_VSCROLL))
	GUICtrlSetOnEvent($File_Menu_New, "GUI_File_New")
	GUICtrlSetOnEvent($File_Menu_Open, "GUI_File_Open")
	GUICtrlSetOnEvent($File_Menu_Save, "GUI_File_Save")
	GUICtrlSetOnEvent($File_Menu_Exit, "Close_Workstation")
	GUICtrlSetOnEvent($File_Menu_Runx86, "GUI_Run_x86")
	GUICtrlSetOnEvent($File_Menu_Runx64, "GUI_Run_x64")
	GUICtrlSetOnEvent($File_Menu_Compiler, "GUI_Compiler")
	GUICtrlSetOnEvent($File_Menu_About, "GUI_About")
	GUISetOnEvent($GUI_EVENT_CLOSE, "Close_Workstation", $GUI_Workstation)
	GUISetState(@SW_SHOW, $GUI_Workstation)
EndFunc
#EndRegion End Workstation GUI Creation


#Region Begin Compiler GUI Creation
Func GUI_Compiler()
	Global $GUI_Compiler = GUICreate("AICompiler GUI", 234, 137, 348, 160)
	Global $GUI_Compiler_Label1 = GUICtrlCreateLabel("Output Name:", 8, 11, 70, 17)
	Global $GUI_Compiler_Label2 = GUICtrlCreateLabel("Compile For:", 8, 35, 62, 17)
	Global $GUI_Compiler_Label3 = GUICtrlCreateLabel("Compression:", 8, 59, 67, 17)
	Global $GUI_Compiler_Label4 = GUICtrlCreateLabel("Comp. w/ UPX:", 8, 83, 78, 17)
	Global $GUI_Compiler_OutputFile = GUICtrlCreateInput("My App", 80, 8, 145, 21)
	Global $GUI_Compiler_x86 = GUICtrlCreateCheckbox("x86", 120, 33, 49, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	Global $GUI_Compiler_x64 = GUICtrlCreateCheckbox("x64", 176, 33, 49, 17)
	Global $GUI_Compiler_Compression = GUICtrlCreateCombo("None", 88, 56, 137, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetData($GUI_Compiler_Compression, "Low|Medium|High|Highest", "None")
	Global $GUI_Compiler_UPXCompression = GUICtrlCreateCombo("Dont Compress", 88, 80, 137, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetData($GUI_Compiler_UPXCompression, "Compress", "Dont Compress")
	Global $GUI_Compiler_Compile_Button = GUICtrlCreateButton("Compile", 136, 104, 91, 25)
	GUICtrlSetOnEvent($GUI_Compiler_Compile_Button, "Compiler")
	GUISetOnEvent($GUI_EVENT_CLOSE, "Close_Compiler", $GUI_Compiler)
	GUISetState(@SW_SHOW, $GUI_Compiler)
EndFunc
#EndRegion End Compiler GUI Creation


#Region Begin Splash GUI Events
Func Close_Spash()
	TrayTip("AIP Response", "Please wait for AIP to finish initializing", 6)
EndFunc
#EndRegion End Splash GUI Creation


#Region Begin Workstation GUI Events
Func GUI_File_New()
	GUICtrlSetData($GUI_Workstation_WorkArea, "")
EndFunc
Func GUI_File_Open()
    Local $f_open_script = FileOpenDialog("Open AutoIt Script", @ScriptDir, "au3 (*.au3)|All (*.*)", 1, $Last_Opened, $GUI_Workstation)
	$Last_Opened = StringTrimLeft($f_open_script, StringInStr($f_open_script, "\", $STR_NOCASESENSE, -1))
	Local $f_open_script_Script = FileRead($f_open_script)
	GUICtrlSetData($GUI_Workstation_WorkArea, $f_open_script_Script)
EndFunc
Func GUI_File_Save()
    Local $f_save_script = FileSaveDialog("Save AutoIt Script", @ScriptDir, "au3 (*.au3)|All (*.*)", 0, $Last_Opened, $GUI_Workstation)
	$Last_Opened = StringTrimLeft($f_save_script, StringInStr($f_save_script, "\", $STR_NOCASESENSE, -1))
	Local $f_script = GUICtrlRead($GUI_Workstation_WorkArea)
	If FileExists($f_save_script) Then FileDelete($f_save_script)
	_FileCreate($f_save_script)
	Local $f_save_script_Open = FileOpen($f_save_script, $FO_APPEND)
	FileWrite($f_save_script_Open, $f_script)
    FileClose($f_save_script_Open)
EndFunc
Func GUI_Run_x86()
	Local $f_script = GUICtrlRead($GUI_Workstation_WorkArea)
	If FileExists($FILE_TEMP_EXE) Then FileDelete($FILE_TEMP_EXE)
	If FileExists($FILE_TEMP) Then FileDelete($FILE_TEMP)
	_FileCreate($FILE_TEMP)
	Local $FILE_TEMP_Open = FileOpen($FILE_TEMP, $FO_APPEND)
	FileWrite($FILE_TEMP_Open, $f_script)
    FileClose($FILE_TEMP_Open)
	RunWait($DIR_TEMP & '/Aut2exe.exe /in "' & $FILE_TEMP & '" /out "' & $FILE_TEMP_EXE & '" /icon "' & $FILE_icon & '" /comp 0 /nopack /x86')
	FileDelete($FILE_TEMP)
	Run($FILE_TEMP_EXE)
EndFunc
Func GUI_Run_x64()
	Local $f_script = GUICtrlRead($GUI_Workstation_WorkArea)
	If FileExists($FILE_TEMP_EXE) Then FileDelete($FILE_TEMP_EXE)
	If FileExists($FILE_TEMP) Then FileDelete($FILE_TEMP)
	_FileCreate($FILE_TEMP)
	Local $FILE_TEMP_Open = FileOpen($FILE_TEMP, $FO_APPEND)
	FileWrite($FILE_TEMP_Open, $f_script)
    FileClose($FILE_TEMP_Open)
	RunWait($DIR_TEMP & '/Aut2exe.exe /in "' & $FILE_TEMP & '" /out "' & $FILE_TEMP_EXE & '" /icon "' & $FILE_icon & '" /comp 0 /nopack /x64')
	FileDelete($FILE_TEMP)
	Run($FILE_TEMP_EXE)
EndFunc
Func GUI_About()
	MsgBox(0, "About AIP", "AutoIt Portable was made by zelles to help people who need AutoIt on the fly." & @CRLF & "Currently running version: 0.0.1")
EndFunc
Func Close_Workstation()
	GUIDelete($GUI_Workstation)
	If FileExists($DIR_TEMP) Then DirRemove($DIR_TEMP, 1)
	Exit
EndFunc
#EndRegion End Workstation GUI Events


#Region Begin Compiler GUI Events
Func Compiler($f_data)
	If Not FileExists($DIR_complier_output) Then DirCreate($DIR_complier_output)
	Local $f_script = GUICtrlRead($GUI_Workstation_WorkArea)
	If FileExists($FILE_TEMP) Then FileDelete($FILE_TEMP)
	_FileCreate($FILE_TEMP)
	Local $FILE_TEMP_Open = FileOpen($FILE_TEMP, $FO_APPEND)
	FileWrite($FILE_TEMP_Open, $f_script)
    FileClose($FILE_TEMP_Open)
	Local $f_OutputFile = GUICtrlRead($GUI_Compiler_OutputFile)
	Local $f_Compression = GUICtrlRead($GUI_Compiler_Compression)
	Local $f_UPXCompression = GUICtrlRead($GUI_Compiler_UPXCompression)
	Switch $f_Compression
		Case "None"
			$f_Compression = " /comp 0"
		Case "Low"
			$f_Compression = " /comp 1"
		Case "Medium"
			$f_Compression = " /comp 2"
		Case "High"
			$f_Compression = " /comp 3"
		Case "Highest"
			$f_Compression = " /comp 4"
	EndSwitch
	Switch $f_UPXCompression
		Case "Dont Compress"
			$f_UPXCompression = " /nopack"
		Case "Compress"
			$f_UPXCompression = " /pack"
	EndSwitch
	If GUICtrlRead($GUI_Compiler_x86) = $GUI_CHECKED Then
		RunWait($DIR_TEMP & '/Aut2exe.exe /in "' & $FILE_TEMP & '" /out "' & $DIR_complier_output & '\' & $f_OutputFile & ' x86.exe" /icon "' & $FILE_icon & '"' & $f_Compression & $f_UPXCompression & ' /x86')
	EndIf
	If GUICtrlRead($GUI_Compiler_x64) = $GUI_CHECKED Then
		RunWait($DIR_TEMP & '/Aut2exe.exe /in "' & $FILE_TEMP & '" /out "' & $DIR_complier_output & '\' & $f_OutputFile & ' x64.exe" /icon "' & $FILE_icon & '"' & $f_Compression & $f_UPXCompression & ' /x64')
	EndIf
	FileDelete($FILE_TEMP)
	GUIDelete($GUI_Compiler)
	MsgBox(0, "AIP Response", "The compiler is finished. Check script directory for files.")
EndFunc
Func Close_Compiler()
	GUIDelete($GUI_Compiler)
EndFunc
#EndRegion End Compiler GUI Events


#Region Begin Temp Appdata Setup
Func Create_Temp_Workstation()
	If Not FileExists($DIR_TEMP) Then DirCreate($DIR_TEMP)
	If Not FileExists($DIR_includes) Then DirCreate($DIR_includes)
	FileInstall("C:\AIP\Icon.ico", $DIR_TEMP & "\Icon.ico", 0)
	FileInstall("C:\AIP\Aut2exe.exe", $DIR_TEMP & "\Aut2exe.exe", 0)
	FileInstall("C:\AIP\upx.exe", $DIR_TEMP & "\upx.exe", 0)
	FileInstall("C:\AIP\includes\APIComConstants.au3", $DIR_includes & "\APIComConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIConstants.au3", $DIR_includes & "\APIConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIDiagConstants.au3", $DIR_includes & "\APIDiagConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIDlgConstants.au3", $DIR_includes & "\APIDlgConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIErrorsConstants.au3", $DIR_includes & "\APIErrorsConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIFilesConstants.au3", $DIR_includes & "\APIFilesConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIGdiConstants.au3", $DIR_includes & "\APIGdiConstants.au3", 0)
	FileInstall("C:\AIP\includes\APILocaleConstants.au3", $DIR_includes & "\APILocaleConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIMiscConstants.au3", $DIR_includes & "\APIMiscConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIProcConstants.au3", $DIR_includes & "\APIProcConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIRegConstants.au3", $DIR_includes & "\APIRegConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIResConstants.au3", $DIR_includes & "\APIResConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIShellExConstants.au3", $DIR_includes & "\APIShellExConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIShPathConstants.au3", $DIR_includes & "\APIShPathConstants.au3", 0)
	FileInstall("C:\AIP\includes\APISysConstants.au3", $DIR_includes & "\APISysConstants.au3", 0)
	FileInstall("C:\AIP\includes\APIThemeConstants.au3", $DIR_includes & "\APIThemeConstants.au3", 0)
	FileInstall("C:\AIP\includes\Array.au3", $DIR_includes & "\Array.au3", 0)
	FileInstall("C:\AIP\includes\AutoItConstants.au3", $DIR_includes & "\AutoItConstants.au3", 0)
	FileInstall("C:\AIP\includes\AVIConstants.au3", $DIR_includes & "\AVIConstants.au3", 0)
	FileInstall("C:\AIP\includes\BorderConstants.au3", $DIR_includes & "\BorderConstants.au3", 0)
	FileInstall("C:\AIP\includes\ButtonConstants.au3", $DIR_includes & "\ButtonConstants.au3", 0)
	FileInstall("C:\AIP\includes\Clipboard.au3", $DIR_includes & "\Clipboard.au3", 0)
	FileInstall("C:\AIP\includes\Color.au3", $DIR_includes & "\Color.au3", 0)
	FileInstall("C:\AIP\includes\ColorConstants.au3", $DIR_includes & "\ColorConstants.au3", 0)
	FileInstall("C:\AIP\includes\ComboConstants.au3", $DIR_includes & "\ComboConstants.au3", 0)
	FileInstall("C:\AIP\includes\Constants.au3", $DIR_includes & "\Constants.au3", 0)
	FileInstall("C:\AIP\includes\Crypt.au3", $DIR_includes & "\Crypt.au3", 0)
	FileInstall("C:\AIP\includes\Date.au3", $DIR_includes & "\Date.au3", 0)
	FileInstall("C:\AIP\includes\DateTimeConstants.au3", $DIR_includes & "\DateTimeConstants.au3", 0)
	FileInstall("C:\AIP\includes\Debug.au3", $DIR_includes & "\Debug.au3", 0)
	FileInstall("C:\AIP\includes\DirConstants.au3", $DIR_includes & "\DirConstants.au3", 0)
	FileInstall("C:\AIP\includes\EditConstants.au3", $DIR_includes & "\EditConstants.au3", 0)
	FileInstall("C:\AIP\includes\EventLog.au3", $DIR_includes & "\EventLog.au3", 0)
	FileInstall("C:\AIP\includes\Excel.au3", $DIR_includes & "\Excel.au3", 0)
	FileInstall("C:\AIP\includes\ExcelConstants.au3", $DIR_includes & "\ExcelConstants.au3", 0)
	FileInstall("C:\AIP\includes\File.au3", $DIR_includes & "\File.au3", 0)
	FileInstall("C:\AIP\includes\FileConstants.au3", $DIR_includes & "\FileConstants.au3", 0)
	FileInstall("C:\AIP\includes\FontConstants.au3", $DIR_includes & "\FontConstants.au3", 0)
	FileInstall("C:\AIP\includes\FrameConstants.au3", $DIR_includes & "\FrameConstants.au3", 0)
	FileInstall("C:\AIP\includes\FTPEx.au3", $DIR_includes & "\FTPEx.au3", 0)
	FileInstall("C:\AIP\includes\GDIPlus.au3", $DIR_includes & "\GDIPlus.au3", 0)
	FileInstall("C:\AIP\includes\GDIPlusConstants.au3", $DIR_includes & "\GDIPlusConstants.au3", 0)
	FileInstall("C:\AIP\includes\GuiAVI.au3", $DIR_includes & "\GuiAVI.au3", 0)
	FileInstall("C:\AIP\includes\GuiButton.au3", $DIR_includes & "\GuiButton.au3", 0)
	FileInstall("C:\AIP\includes\GuiComboBox.au3", $DIR_includes & "\GuiComboBox.au3", 0)
	FileInstall("C:\AIP\includes\GuiComboBoxEx.au3", $DIR_includes & "\GuiComboBoxEx.au3", 0)
	FileInstall("C:\AIP\includes\GUIConstants.au3", $DIR_includes & "\GUIConstants.au3", 0)
	FileInstall("C:\AIP\includes\GUIConstantsEx.au3", $DIR_includes & "\GUIConstantsEx.au3", 0)
	FileInstall("C:\AIP\includes\GuiDateTimePicker.au3", $DIR_includes & "\GuiDateTimePicker.au3", 0)
	FileInstall("C:\AIP\includes\GuiEdit.au3", $DIR_includes & "\GuiEdit.au3", 0)
	FileInstall("C:\AIP\includes\GuiHeader.au3", $DIR_includes & "\GuiHeader.au3", 0)
	FileInstall("C:\AIP\includes\GuiImageList.au3", $DIR_includes & "\GuiImageList.au3", 0)
	FileInstall("C:\AIP\includes\GuiIPAddress.au3", $DIR_includes & "\GuiIPAddress.au3", 0)
	FileInstall("C:\AIP\includes\GuiListBox.au3", $DIR_includes & "\GuiListBox.au3", 0)
	FileInstall("C:\AIP\includes\GuiListView.au3", $DIR_includes & "\GuiListView.au3", 0)
	FileInstall("C:\AIP\includes\GuiMenu.au3", $DIR_includes & "\GuiMenu.au3", 0)
	FileInstall("C:\AIP\includes\GuiMonthCal.au3", $DIR_includes & "\GuiMonthCal.au3", 0)
	FileInstall("C:\AIP\includes\GuiReBar.au3", $DIR_includes & "\GuiReBar.au3", 0)
	FileInstall("C:\AIP\includes\GuiRichEdit.au3", $DIR_includes & "\GuiRichEdit.au3", 0)
	FileInstall("C:\AIP\includes\GuiScrollBars.au3", $DIR_includes & "\GuiScrollBars.au3", 0)
	FileInstall("C:\AIP\includes\GuiSlider.au3", $DIR_includes & "\GuiSlider.au3", 0)
	FileInstall("C:\AIP\includes\GuiStatusBar.au3", $DIR_includes & "\GuiStatusBar.au3", 0)
	FileInstall("C:\AIP\includes\GuiTab.au3", $DIR_includes & "\GuiTab.au3", 0)
	FileInstall("C:\AIP\includes\GuiToolbar.au3", $DIR_includes & "\GuiToolbar.au3", 0)
	FileInstall("C:\AIP\includes\GuiToolTip.au3", $DIR_includes & "\GuiToolTip.au3", 0)
	FileInstall("C:\AIP\includes\GuiTreeView.au3", $DIR_includes & "\GuiTreeView.au3", 0)
	FileInstall("C:\AIP\includes\HeaderConstants.au3", $DIR_includes & "\HeaderConstants.au3", 0)
	FileInstall("C:\AIP\includes\IE.au3", $DIR_includes & "\IE.au3", 0)
	FileInstall("C:\AIP\includes\ImageListConstants.au3", $DIR_includes & "\ImageListConstants.au3", 0)
	FileInstall("C:\AIP\includes\Inet.au3", $DIR_includes & "\Inet.au3", 0)
	FileInstall("C:\AIP\includes\InetConstants.au3", $DIR_includes & "\InetConstants.au3", 0)
	FileInstall("C:\AIP\includes\IPAddressConstants.au3", $DIR_includes & "\IPAddressConstants.au3", 0)
	FileInstall("C:\AIP\includes\ListBoxConstants.au3", $DIR_includes & "\ListBoxConstants.au3", 0)
	FileInstall("C:\AIP\includes\ListViewConstants.au3", $DIR_includes & "\ListViewConstants.au3", 0)
	FileInstall("C:\AIP\includes\Math.au3", $DIR_includes & "\Math.au3", 0)
	FileInstall("C:\AIP\includes\Memory.au3", $DIR_includes & "\Memory.au3", 0)
	FileInstall("C:\AIP\includes\MemoryConstants.au3", $DIR_includes & "\MemoryConstants.au3", 0)
	FileInstall("C:\AIP\includes\MenuConstants.au3", $DIR_includes & "\MenuConstants.au3", 0)
	FileInstall("C:\AIP\includes\Misc.au3", $DIR_includes & "\Misc.au3", 0)
	FileInstall("C:\AIP\includes\MsgBoxConstants.au3", $DIR_includes & "\MsgBoxConstants.au3", 0)
	FileInstall("C:\AIP\includes\NamedPipes.au3", $DIR_includes & "\NamedPipes.au3", 0)
	FileInstall("C:\AIP\includes\NetShare.au3", $DIR_includes & "\NetShare.au3", 0)
	FileInstall("C:\AIP\includes\NTSTATUSConstants.au3", $DIR_includes & "\NTSTATUSConstants.au3", 0)
	FileInstall("C:\AIP\includes\Process.au3", $DIR_includes & "\Process.au3", 0)
	FileInstall("C:\AIP\includes\ProcessConstants.au3", $DIR_includes & "\ProcessConstants.au3", 0)
	FileInstall("C:\AIP\includes\ProgressConstants.au3", $DIR_includes & "\ProgressConstants.au3", 0)
	FileInstall("C:\AIP\includes\RebarConstants.au3", $DIR_includes & "\RebarConstants.au3", 0)
	FileInstall("C:\AIP\includes\RichEditConstants.au3", $DIR_includes & "\RichEditConstants.au3", 0)
	FileInstall("C:\AIP\includes\ScreenCapture.au3", $DIR_includes & "\ScreenCapture.au3", 0)
	FileInstall("C:\AIP\includes\ScrollBarConstants.au3", $DIR_includes & "\ScrollBarConstants.au3", 0)
	FileInstall("C:\AIP\includes\ScrollBarsConstants.au3", $DIR_includes & "\ScrollBarsConstants.au3", 0)
	FileInstall("C:\AIP\includes\Security.au3", $DIR_includes & "\Security.au3", 0)
	FileInstall("C:\AIP\includes\SecurityConstants.au3", $DIR_includes & "\SecurityConstants.au3", 0)
	FileInstall("C:\AIP\includes\SendMessage.au3", $DIR_includes & "\SendMessage.au3", 0)
	FileInstall("C:\AIP\includes\SliderConstants.au3", $DIR_includes & "\SendMessage.au3", 0)
	FileInstall("C:\AIP\includes\Sound.au3", $DIR_includes & "\Sound.au3", 0)
	FileInstall("C:\AIP\includes\SQLite.au3", $DIR_includes & "\SQLite.au3", 0)
	FileInstall("C:\AIP\includes\SQLite.dll.au3", $DIR_includes & "\SQLite.dll.au3", 0)
	FileInstall("C:\AIP\includes\StaticConstants.au3", $DIR_includes & "\StaticConstants.au3", 0)
	FileInstall("C:\AIP\includes\StatusBarConstants.au3", $DIR_includes & "\StatusBarConstants.au3", 0)
	FileInstall("C:\AIP\includes\String.au3", $DIR_includes & "\String.au3", 0)
	FileInstall("C:\AIP\includes\StringConstants.au3", $DIR_includes & "\StringConstants.au3", 0)
	FileInstall("C:\AIP\includes\StructureConstants.au3", $DIR_includes & "\StructureConstants.au3", 0)
	FileInstall("C:\AIP\includes\TabConstants.au3", $DIR_includes & "\TabConstants.au3", 0)
	FileInstall("C:\AIP\includes\Timers.au3", $DIR_includes & "\Timers.au3", 0)
	FileInstall("C:\AIP\includes\ToolbarConstants.au3", $DIR_includes & "\ToolbarConstants.au3", 0)
	FileInstall("C:\AIP\includes\ToolTipConstants.au3", $DIR_includes & "\ToolTipConstants.au3", 0)
	FileInstall("C:\AIP\includes\TrayConstants.au3", $DIR_includes & "\TrayConstants.au3", 0)
	FileInstall("C:\AIP\includes\TreeViewConstants.au3", $DIR_includes & "\TreeViewConstants.au3", 0)
	FileInstall("C:\AIP\includes\UDFGlobalID.au3", $DIR_includes & "\UDFGlobalID.au3", 0)
	FileInstall("C:\AIP\includes\UpDownConstants.au3", $DIR_includes & "\UpDownConstants.au3", 0)
	FileInstall("C:\AIP\includes\Visa.au3", $DIR_includes & "\Visa.au3", 0)
	FileInstall("C:\AIP\includes\WinAPI.au3", $DIR_includes & "\WinAPI.au3", 0)
	FileInstall("C:\AIP\includes\WinAPICom.au3", $DIR_includes & "\WinAPICom.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIConstants.au3", $DIR_includes & "\WinAPIConstants.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIDiag.au3", $DIR_includes & "\WinAPIDiag.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIDlg.au3", $DIR_includes & "\WinAPIDlg.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIError.au3", $DIR_includes & "\WinAPIError.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIEx.au3", $DIR_includes & "\WinAPIEx.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIFiles.au3", $DIR_includes & "\WinAPIFiles.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIGdi.au3", $DIR_includes & "\WinAPIGdi.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIInternals.au3", $DIR_includes & "\WinAPIInternals.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIlangConstants.au3", $DIR_includes & "\WinAPIlangConstants.au3", 0)
	FileInstall("C:\AIP\includes\WinAPILocale.au3", $DIR_includes & "\WinAPILocale.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIMisc.au3", $DIR_includes & "\WinAPIMisc.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIProc.au3", $DIR_includes & "\WinAPIProc.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIReg.au3", $DIR_includes & "\WinAPIReg.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIRes.au3", $DIR_includes & "\WinAPIRes.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIShellEx.au3", $DIR_includes & "\WinAPIShellEx.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIShPath.au3", $DIR_includes & "\WinAPIShPath.au3", 0)
	FileInstall("C:\AIP\includes\WinAPISys.au3", $DIR_includes & "\WinAPISys.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIsysinfoConstants.au3", $DIR_includes & "\WinAPIsysinfoConstants.au3", 0)
	FileInstall("C:\AIP\includes\WinAPITheme.au3", $DIR_includes & "\WinAPITheme.au3", 0)
	FileInstall("C:\AIP\includes\WinAPIvkeysConstants.au3", $DIR_includes & "\WinAPIvkeysConstants.au3", 0)
	FileInstall("C:\AIP\includes\WindowsConstants.au3", $DIR_includes & "\WindowsConstants.au3", 0)
	FileInstall("C:\AIP\includes\WinNet.au3", $DIR_includes & "\WinNet.au3", 0)
	FileInstall("C:\AIP\includes\Word.au3", $DIR_includes & "\Word.au3", 0)
	FileInstall("C:\AIP\includes\WordConstants.au3", $DIR_includes & "\WordConstants.au3", 0)
EndFunc
#EndRegion End Temp Appdata Setup