#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\AIP\Icon.ico
#AutoIt3Wrapper_Res_Description=Compile your AutoIt scripts on the fly!
#AutoIt3Wrapper_Res_Fileversion=0.0.3
#AutoIt3Wrapper_Res_LegalCopyright=Copyright 2014 zelles
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <File.au3>
#include <GUIConstantsEx.au3>
#include <Misc.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

_Singleton("AutoItPortableByzelles")
Opt("GUIOnEventMode", 1)
Opt("TrayMenuMode", 3)

Global $DIR_complier_output = @ScriptDir & "\compiled"
Global $DIR_TEMP = @ScriptDir & "\temp_appdata"
Global $DIR_includes = $DIR_TEMP & "\includes"
Global $FILE_icon = $DIR_TEMP & "\Icon.ico"
Global $FILE_TEMP = $DIR_includes & "\aip_temp.au3"
Global $FILE_TEMP_EXE = $DIR_TEMP & "\aip_temp.exe"
Global $IMG_Splash = $DIR_TEMP & "\splash.gif"
Global $Last_Opened = "AIPScript.au3"

Global $AUTOIT_CODES = ''
$AUTOIT_CODES &= 'Local||Global||If||Then||ElseIf||Else||EndIf||Case||Switch||EndSwitch||Select||EndSelect||While||WEnd||With||EndWith||Do||Until||For||Next||In||To||Or||And||True||False||Return||Exit||ExitLoop||Dim||ReDim||Const||ContinueCase||ContinueLoop||Not||Null||ByRef||Default||Func||EndFunc||Enum||Static||Step||Volatile'
$AUTOIT_CODES &= '||Opt("CaretCoordMode",1)||Opt("ExpandEnvStrings",0)||Opt("ExpandVarStrings",0)||Opt("GUICloseOnESC",1)||Opt("GUICoordMode",1)||Opt("GUIDataSeparatorChar","|")||Opt("GUIOnEventMode",0)||Opt("GUIResizeMode",0)||Opt("GUIEventOptions",0)||Opt("MouseClickDelay",10)||Opt("MouseClickDownDelay",10)||Opt("MouseClickDragDelay",250)||Opt("MouseCoordMode",1)||Opt("MustDeclareVars",0)||Opt("PixelCoordMode",1)||Opt("SendAttachMode",0)||Opt("SendCapslockMode",1)||Opt("SendKeyDelay",5)||Opt("SendKeyDownDelay",1)||Opt("TCPTimeout",100)||Opt("TrayAutoPause",1)||Opt("TrayIconDebug",0)||Opt("TrayIconHide",0)||Opt("TrayMenuMode",0)||Opt("TrayOnEventMode",0)||Opt("WinDetectHiddenText",0)||Opt("WinSearchChildren",1)||Opt("WinTextMatchMode",1)||Opt("WinTitleMatchMode",1)||Opt("WinWaitDelay",250)'
$AUTOIT_CODES &= '||@AppDataCommonDir||@AppDataDir||@AutoItExe||@AutoItPID||@AutoItVersion||@AutoItX64||@COM_EventObj||@CommonFilesDir||@Compiled||@ComputerName||@ComSpec||@CPUArch||@CR||@CRLF||@CR||@LF||@DesktopCommonDir||@DesktopDepth||@DesktopDir||@DesktopHeight||@DesktopRefresh||@DesktopWidth||@DocumentsCommonDir||@error||@exitCode||@exitMethod||@extended||@FavoritesCommonDir||@FavoritesDir||@GUI_CtrlHandle||@GUI_CtrlId||@GUI_DragFile||@GUI_DragId||@GUI_DropId||@GUI_WinHandle||@HomeDrive||@HomePath||@HomeShare||@HotKeyPressed||@HOUR||@IPAddress1||@IPAddress2||@IPAddress3||@IPAddress4||@KBLayout||@LF||@LocalAppDataDir||@LogonDNSDomain||@LogonDomain||@LogonServer||@MDAY||@MIN||@MON||@MSEC||@MUILang||@MyDocumentsDir||@NumParams||@OSArch||@OSBuild||@OSLang||@OSServicePack||@OSType||@OSVersion||@ProgramFilesDir||@ProgramsCommonDir||@ProgramsDir||@ScriptDir||@ScriptFullPath||@ScriptLineNumber||@ScriptName||@SEC||@StartMenuCommonDir||@StartMenuDir||@StartupCommonDir||@StartupDir||@SW_DISABLE||@SW_ENABLE||@SW_HIDE||@SW_LOCK||@SW_MAXIMIZE||@SW_MINIMIZE||@SW_RESTORE||@SW_SHOW||@SW_SHOWDEFAULT||@SW_SHOWMAXIMIZED||@SW_SHOWMINIMIZED||@SW_SHOWMINNOACTIVE||@SW_SHOWNA||@SW_SHOWNOACTIVATE||@SW_SHOWNORMAL||@SW_UNLOCK||@SystemDir||@TAB||@TempDir||@TRAY_ID||@TrayIconFlashing||@TrayIconVisible||@UserName||@UserProfileDir||@WDAY||@WindowsDir||@WorkingDir||@YDAY||@YEAR'
$AUTOIT_CODES &= '||#cs||#ce||#include||#include-once||#NoTrayIcon||#RequireAdmin||#OnAutoItStartRegister||#Region||#EndRegion||#pragma compile'
$AUTOIT_CODES &= '||<APIComConstants.au3>||<APIConstants.au3>||<APIDiagConstants.au3>||<APIDlgConstants.au3>||<APIErrorsConstants.au3>||<APIFilesConstants.au3>||<APIGdiConstants.au3>||<APILocaleConstants.au3>||<APIMiscConstants.au3>||<APIProcConstants.au3>||<APIRegConstants.au3>||<APIResConstants.au3>||<APIShellExConstants.au3>||<APIShPathConstants.au3>||<APISysConstants.au3>||<APIThemeConstants.au3>||<Array.au3>||<AutoItConstants.au3>||<AVIConstants.au3>||<BorderConstants.au3>||<ButtonConstants.au3>||<Clipboard.au3>||<Color.au3>||<ColorConstants.au3>||<ComboConstants.au3>||<Constants.au3>||<Crypt.au3>||<Date.au3>||<DateTimeConstants.au3>||<Debug.au3>||<DirConstants.au3>||<EditConstants.au3>||<EventLog.au3>||<Excel.au3>||<ExcelConstants.au3>||<File.au3>||<FileConstants.au3>||<FontConstants.au3>||<FrameConstants.au3>||<FTPEx.au3>||<GDIPlus.au3>||<GDIPlusConstants.au3>||<GuiAVI.au3>||<GuiButton.au3>||<GuiComboBox.au3>||<GuiComboBoxEx.au3>'
$AUTOIT_CODES &= '||<GUIConstants.au3>||<GUIConstantsEx.au3>||<GuiDateTimePicker.au3>||<GuiEdit.au3>||<GuiHeader.au3>||<GuiImageList.au3>||<GuiIPAddress.au3>||<GuiListBox.au3>||<GuiListView.au3>||<GuiMenu.au3>||<GuiMonthCal.au3>||<GuiReBar.au3>||<GuiRichEdit.au3>||<GuiScrollBars.au3>||<GuiSlider.au3>||<GuiStatusBar.au3>||<GuiTab.au3>||<GuiToolbar.au3>||<GuiToolTip.au3>||<GuiTreeView.au3>||<HeaderConstants.au3>||<IE.au3>||<ImageListConstants.au3>||<Inet.au3>||<InetConstants.au3>||<IPAddressConstants.au3>||<ListBoxConstants.au3>||<ListViewConstants.au3>||<Math.au3>||<Memory.au3>||<MemoryConstants.au3>||<MenuConstants.au3>||<Misc.au3>||<MsgBoxConstants.au3>||<NamedPipes.au3>||<NetShare.au3>||<NTSTATUSConstants.au3>||<Process.au3>||<ProcessConstants.au3>||<ProgressConstants.au3>||<RebarConstants.au3>||<RichEditConstants.au3>||<ScreenCapture.au3>||<ScrollBarConstants.au3>||<ScrollBarsConstants.au3>||<Security.au3>||<SecurityConstants.au3>'
$AUTOIT_CODES &= '||<SendMessage.au3>||<SliderConstants.au3>||<Sound.au3>||<SQLite.au3>||<SQLite.dll.au3>||<StaticConstants.au3>||<StatusBarConstants.au3>||<String.au3>||<StringConstants.au3>||include <StructureConstants.au3>||<TabConstants.au3>||<Timers.au3>||<ToolbarConstants.au3>||<ToolTipConstants.au3>||<TrayConstants.au3>||<TreeViewConstants.au3>||<UDFGlobalID.au3>||<UpDownConstants.au3>||<Visa.au3>||<WinAPI.au3>||<WinAPICom.au3>||<WinAPIConstants.au3>||<WinAPIDiag.au3>||<WinAPIDlg.au3>||<WinAPIError.au3>||<WinAPIEx.au3>||<WinAPIFiles.au3>||<WinAPIGdi.au3>||<WinAPIInternals.au3>||<WinAPIlangConstants.au3>||<WinAPILocale.au3>||<WinAPIMisc.au3>||<WinAPIProc.au3>||<WinAPIReg.au3>||<WinAPIRes.au3>||<WinAPIShellEx.au3>||<WinAPIShPath.au3>||<WinAPISys.au3>||<WinAPIsysinfoConstants.au3>||<WinAPITheme.au3>||<WinAPIvkeysConstants.au3>||<WindowsConstants.au3>||<WinNet.au3>||<Word.au3>||<WordConstants.au3>'
$AUTOIT_CODES &= '||Abs||ACos||AdlibRegister||AdlibUnRegister||Asc||AscW||ASin||Assign||ATan||AutoItSetOption||AutoItWinGetTitle||AutoItWinSetTitle||Beep||Binary||BinaryLen||BinaryMid||BinaryToString||BitAND||BitNOT||BitOR||BitRotate||BitShift||BitXOR||BlockInput||Break||Call||CDTray||Ceiling||Chr||ChrW||ClipGet||ClipPut||ConsoleRead||ConsoleWrite||ConsoleWriteError||ControlClick||ControlCommand||ControlDisable||ControlEnable||ControlFocus||ControlGetFocus||ControlGetHandle||ControlGetPos||ControlGetText||ControlHide||ControlListView||ControlMove||ControlSend||ControlSetText||ControlShow||ControlTreeView||Cos||Dec||DirCopy||DirCreate||DirGetSize||DirMove||DirRemove||DllCall||DllCallAddress||DllCallbackFree||DllCallbackGetPtr||DllCallbackRegister||DllClose||DllOpen||DllStructCreate||DllStructGetData||DllStructGetPtr||DllStructGetSize||DllStructSetData||DriveGetDrive||DriveGetFileSystem||DriveGetLabel||DriveGetSerial||DriveGetType||DriveMapAdd||DriveMapDel||DriveMapGet||DriveSetLabel||DriveSpaceFree||DriveSpaceTotal||DriveStatus||EnvGet||EnvSet||EnvUpdate||Eval||Execute||Exp||FileChangeDir||FileClose||FileCopy||FileCreateNTFSLink||FileCreateShortcut||FileDelete||FileExists||FileFindFirstFile||FileFindNextFile||FileFlush||FileGetAttrib||FileGetEncoding||FileGetLongName||FileGetPos||FileGetShortcut||FileGetShortName||FileGetSize||FileGetTime'
$AUTOIT_CODES &= '||FileGetVersion||FileInstall||FileMove||FileOpen||FileOpenDialog||FileRead||FileReadLine||FileReadToArray||FileRecycle||FileRecycleEmpty||FileSaveDialog||FileSelectFolder||FileSetAttrib||FileSetPos||FileSetTime||FileWrite||FileWriteLine||Floor||FtpSetProxy||FuncName||GUICreate||GUICtrlCreateAvi||GUICtrlCreateButton||GUICtrlCreateCheckbox||GUICtrlCreateCombo||GUICtrlCreateContextMenu||GUICtrlCreateDate||GUICtrlCreateDummy||GUICtrlCreateEdit||GUICtrlCreateGraphic||GUICtrlCreateGroup||GUICtrlCreateIcon||GUICtrlCreateInput||GUICtrlCreateLabel||GUICtrlCreateList||GUICtrlCreateListView||GUICtrlCreateListViewItem||GUICtrlCreateMenu||GUICtrlCreateMenuItem||GUICtrlCreateMonthCal||GUICtrlCreateObj||GUICtrlCreatePic||GUICtrlCreateProgress||GUICtrlCreateRadio||GUICtrlCreateSlider||GUICtrlCreateTab||GUICtrlCreateTabItem||GUICtrlCreateTreeView||GUICtrlCreateTreeViewItem||GUICtrlCreateUpdown||GUICtrlDelete||GUICtrlGetHandle||GUICtrlGetState||GUICtrlRead||GUICtrlRecvMsg||GUICtrlRegisterListViewSort||GUICtrlSendMsg||GUICtrlSendToDummy||GUICtrlSetBkColor||GUICtrlSetColor||GUICtrlSetCursor||GUICtrlSetData||GUICtrlSetDefBkColor||GUICtrlSetDefColor||GUICtrlSetFont||GUICtrlSetGraphic||GUICtrlSetImage||GUICtrlSetLimit||GUICtrlSetOnEvent||GUICtrlSetPos||GUICtrlSetResizing||GUICtrlSetState||GUICtrlSetStyle||GUICtrlSetTip||GUIDelete'
$AUTOIT_CODES &= '||GUIGetCursorInfo||GUIGetMsg||GUIGetStyle||GUIRegisterMsg||GUISetAccelerators||GUISetBkColor||GUISetCoord||GUISetCursor||GUISetFont||GUISetHelp||GUISetIcon||GUISetOnEvent||GUISetState||GUISetStyle||GUIStartGroup||GUISwitch||Hex||HotKeySet||HttpSetProxy||HttpSetUserAgent||HWnd||InetClose||InetGet||InetGetInfo||InetGetSize||InetRead||IniDelete||IniRead||IniReadSection||IniReadSectionNames||IniRenameSection||IniWrite||IniWriteSection||InputBox||Int||IsAdmin||IsArray||IsBinary||IsBool||IsDeclared||IsDllStruct||IsFloat||IsFunc||IsHWnd||IsInt||IsKeyword||IsNumber||IsObj||IsPtr||IsString||Log||MemGetStats||Mod||MouseClick||MouseClickDrag||MouseDown||MouseGetCursor||MouseGetPos||MouseMove||MouseUp||MouseWheel||MsgBox||Number||ObjCreate||ObjCreateInterface||ObjEvent||ObjGet||ObjName||OnAutoItExitRegister||OnAutoItExitUnRegister||Ping||PixelChecksum||PixelGetColor||PixelSearch||ProcessClose||ProcessExists||ProcessGetStats||ProcessList||ProcessSetPriority||ProcessWait||ProcessWaitClose||ProgressOff||ProgressOn||ProgressSet||Ptr||Random||RegDelete||RegEnumKey||RegEnumVal||RegRead||RegWrite||Round||Run||RunAs||RunAsWait||RunWait||Send||SendKeepActive||SetError||SetExtended||ShellExecute||ShellExecuteWait||Shutdown||Sin||Sleep||SoundPlay||SoundSetWaveVolume||SplashImageOn||SplashOff||SplashTextOn||Sqrt||SRandom||StatusbarGetText||StderrRead'
$AUTOIT_CODES &= '||StdinWrite||StdioClose||StdoutRead||String||StringAddCR||StringCompare||StringFormat||StringFromASCIIArray||StringInStr||StringIsAlNum||StringIsAlpha||StringIsASCII||StringIsDigit||StringIsFloat||StringIsInt||StringIsLower||StringIsSpace||StringIsUpper||StringIsXDigit||StringLeft||StringLen||StringLower||StringMid||StringRegExp||StringRegExpReplace||StringReplace||StringReverse||StringRight||StringSplit||StringStripCR||StringStripWS||StringToASCIIArray||StringToBinary||StringTrimLeft||StringTrimRight||StringUpper||Tan||TCPAccept||TCPCloseSocket||TCPConnect||TCPListen||TCPNameToIP||TCPRecv||TCPSend||TCPShutdown||UDPShutdown||TCPStartup||UDPStartup||TimerDiff||TimerInit||ToolTip||TrayCreateItem||TrayCreateMenu||TrayGetMsg||TrayItemDelete||TrayItemGetHandle||TrayItemGetState||TrayItemGetText||TrayItemSetOnEvent||TrayItemSetState||TrayItemSetText||TraySetClick||TraySetIcon||TraySetOnEvent||TraySetPauseIcon||TraySetState||TraySetToolTip||TrayTip||UBound||UDPBind||UDPCloseSocket||UDPOpen||UDPRecv||UDPSend||VarGetType||WinActivate||WinActive||WinClose||WinExists||WinFlash||WinGetCaretPos||WinGetClassList||WinGetClientSize||WinGetHandle||WinGetPos||WinGetProcess||WinGetState||WinGetText||WinGetTitle||WinKill||WinList||WinMenuSelectItem||WinMinimizeAll||WinMinimizeAllUndo||WinMove||WinSetOnTop||WinSetState||WinSetTitle||WinSetTrans'
$AUTOIT_CODES &= '||WinWait||WinWaitActive||WinWaitClose||WinWaitNotActive'

GUI_Splash()
Create_Temp_Workstation()
GUIDelete($GUI_Splash)
GUI_Workstation()

While 1
	ImportCustomIncludes()
	Local $w_all = GUICtrlRead($GUI_Workstation_WorkArea)
	Local $w_all_one = StringReplace($w_all, @CRLF, " ")
	Local $w_words = StringSplit($w_all_one, " ", 1)
	Local $w_last_word = StringReplace($w_words[$w_words[0]], " ", "")
	Local $w_last_word_length = StringLen($w_last_word)
	If $w_last_word == "" Then GUICtrlSetData($GUI_Workstation_Suggestions, "")
	If $w_last_word == "" Then ContinueLoop
	$AUTOIT_CODE = StringSplit($AUTOIT_CODES, "||", 1)
	$AUTOIT_SUGGESTIONS = ""
	For $aic = 1 To $AUTOIT_CODE[0]
		$w_autoit_matcher = StringMid($AUTOIT_CODE[$aic], 1, $w_last_word_length)
		If StringLower($w_last_word) == StringLower($w_autoit_matcher) Then
			$AUTOIT_SUGGESTIONS &= $AUTOIT_CODE[$aic] & @CRLF
		EndIf
	Next
	If GUICtrlRead($GUI_Workstation_Suggestions) == $AUTOIT_SUGGESTIONS Then ContinueLoop
	GUICtrlSetData($GUI_Workstation_Suggestions, $AUTOIT_SUGGESTIONS)
	Sleep(100)
WEnd

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

Func GUI_Workstation()
	Global $GUI_Workstation = GUICreate("AutoIt Portable Workstation", 801, 431, 181, 90)
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
	GUISetFont(9, 400, 0, "Arial")
	GUISetBkColor(0xB9D1EA)
	Global $GUI_Workstation_WorkArea = GUICtrlCreateEdit(@CRLF & 'MsgBox(0, "Welcome Note", "Thank you for using AutoIt Portable!")' & @CRLF, 200, 0, 600, 409, BitOR($ES_AUTOVSCROLL,$ES_WANTRETURN,$WS_VSCROLL))
	GUICtrlSetColor(-1, 0x000000)
	Global $GUI_Workstation_Suggestions = GUICtrlCreateEdit("", 0, 24, 201, 385, BitOR($ES_AUTOVSCROLL,$ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
	GUICtrlSetFont(-1, 8, 400, 0, "Arial")
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetBkColor(-1, 0xD7E4F2)
	Local $Label1 = GUICtrlCreateLabel("Code Suggestions:", 3, 5, 110, 19)
	GUICtrlSetFont(-1, 9, 800, 0, "Arial")
	GUICtrlSetColor(-1, 0x000000)
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

Func GUI_Compiler()
	Global $GUI_Compiler = GUICreate("AICompiler GUI", 234, 447, 325, 143)
	Local $GUI_Compiler_Label1 = GUICtrlCreateLabel("App Name:", 8, 11, 57, 17)
	Local $GUI_Compiler_Label2 = GUICtrlCreateLabel("App Icon:", 8, 35, 50, 17)
	Local $GUI_Compiler_Label3 = GUICtrlCreateLabel("Product Name:", 8, 59, 75, 17)
	Local $GUI_Compiler_Label4 = GUICtrlCreateLabel("Company Name:", 8, 83, 82, 17)
	Local $GUI_Compiler_Label5 = GUICtrlCreateLabel("Copyright:", 8, 107, 51, 17)
	Local $GUI_Compiler_Label6 = GUICtrlCreateLabel("Trademarks:", 8, 131, 63, 17)
	Local $GUI_Compiler_Label7 = GUICtrlCreateLabel("File Version:", 8, 155, 61, 17)
	Local $GUI_Compiler_Label8 = GUICtrlCreateLabel("Product Version:", 8, 179, 82, 17)
	Local $GUI_Compiler_Label9 = GUICtrlCreateLabel("Description:", 8, 203, 60, 17)
	Local $GUI_Compiler_Label10 = GUICtrlCreateLabel("Comment:", 8, 227, 51, 17)
	Local $GUI_Compiler_Label11 = GUICtrlCreateLabel("Ignore Directives:", 8, 251, 87, 17)
	Local $GUI_Compiler_Label12 = GUICtrlCreateLabel("Compile For:", 8, 275, 62, 17)
	Local $GUI_Compiler_Label13 = GUICtrlCreateLabel("Compression:", 8, 299, 67, 17)
	Local $GUI_Compiler_Label14 = GUICtrlCreateLabel("Comp. w/ UPX:", 8, 323, 78, 17)
	Local $GUI_Compiler_Label15 = GUICtrlCreateLabel("Execution Level:", 8, 347, 83, 17)
	Local $GUI_Compiler_Label16 = GUICtrlCreateLabel("Compatibility:", 8, 371, 65, 17)
	Local $GUI_Compiler_Label17 = GUICtrlCreateLabel("App Type:", 8, 395, 53, 17)
	Global $GUI_Compiler_OutputFile = GUICtrlCreateInput("My App", 72, 8, 153, 21)
	Global $GUI_Compiler_IconFile = GUICtrlCreateInput($FILE_icon, 72, 32, 105, 21)
	Global $GUI_Compiler_LoadIcon_Button = GUICtrlCreateButton("Load", 184, 32, 43, 21)
	Global $GUI_Compiler_ProductName = GUICtrlCreateInput("", 88, 56, 137, 21)
	Global $GUI_Compiler_CompanyName = GUICtrlCreateInput("", 88, 80, 137, 21)
	Global $GUI_Compiler_Copyright = GUICtrlCreateInput("", 72, 104, 153, 21)
	Global $GUI_Compiler_Trademarks = GUICtrlCreateInput("", 72, 128, 153, 21)
	Global $GUI_Compiler_FileVersion = GUICtrlCreateInput("", 88, 152, 137, 21)
	Global $GUI_Compiler_ProductVersion = GUICtrlCreateInput("", 88, 176, 137, 21)
	Global $GUI_Compiler_Description = GUICtrlCreateInput("", 72, 200, 153, 21)
	Global $GUI_Compiler_Comment = GUICtrlCreateInput("", 72, 224, 153, 21)
	Global $GUI_Compiler_IgnoreDirectives = GUICtrlCreateCheckbox("Ignore", 120, 248, 65, 17)
	Global $GUI_Compiler_x86 = GUICtrlCreateCheckbox("x86", 120, 273, 49, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	Global $GUI_Compiler_x64 = GUICtrlCreateCheckbox("x64", 176, 273, 49, 17)
	Global $GUI_Compiler_Compression = GUICtrlCreateCombo("None", 88, 296, 137, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetData($GUI_Compiler_Compression, "Low|Medium|High|Highest", "None")
	Global $GUI_Compiler_UPXCompression = GUICtrlCreateCombo("Dont Compress", 88, 320, 137, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetData($GUI_Compiler_UPXCompression, "Compress", "Dont Compress")
	Global $GUI_Compiler_ExecutionLevel = GUICtrlCreateCombo("None", 88, 344, 137, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetData($GUI_Compiler_ExecutionLevel, "AsInvoker|Highest Avail|Require Admin", "None")
	Global $GUI_Compiler_Compatibility = GUICtrlCreateCombo("All", 88, 368, 137, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetData($GUI_Compiler_Compatibility, "Windows Vista|Windows 7|Windows 8", "All")
	Global $GUI_Compiler_AppType = GUICtrlCreateCombo("Default", 88, 392, 137, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetData($GUI_Compiler_AppType, "GUI|Console", "Default")
	Global $GUI_Compiler_Compile_Button = GUICtrlCreateButton("Compile", 136, 416, 91, 25)
	GUICtrlSetOnEvent($GUI_Compiler_LoadIcon_Button, "Compiler")
	GUICtrlSetOnEvent($GUI_Compiler_Compile_Button, "Compiler")
	GUISetOnEvent($GUI_EVENT_CLOSE, "Close_Compiler", $GUI_Compiler)
	GUISetState(@SW_SHOW, $GUI_Compiler)
EndFunc

Func Close_Spash()
	TrayTip("AIP Response", "Please wait for AIP to finish initializing", 6)
EndFunc

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

Func Compiler($f_data)
	; Unintergrated commands: /ansi /unicode /originalfilename "" /internalname ""
	If Not FileExists($DIR_complier_output) Then DirCreate($DIR_complier_output)
	Local $f_script = GUICtrlRead($GUI_Workstation_WorkArea)
	If FileExists($FILE_TEMP) Then FileDelete($FILE_TEMP)
	_FileCreate($FILE_TEMP)
	Local $FILE_TEMP_Open = FileOpen($FILE_TEMP, $FO_APPEND)
	FileWrite($FILE_TEMP_Open, $f_script)
    FileClose($FILE_TEMP_Open)
	Local $Compiler_Script_x86 = $DIR_TEMP & '/Aut2exe.exe'
	Local $Compiler_Script_x64 = $DIR_TEMP & '/Aut2exe.exe'
	$Compiler_Script_x86 &= ' /in "' & $FILE_TEMP & '"'
	$Compiler_Script_x64 &= ' /in "' & $FILE_TEMP & '"'
	Local $f_OutputFile = GUICtrlRead($GUI_Compiler_OutputFile)
	$Compiler_Script_x86 &= ' /out "' & $DIR_complier_output & '\' & $f_OutputFile & ' x86.exe"'
	$Compiler_Script_x64 &= ' /out "' & $DIR_complier_output & '\' & $f_OutputFile & ' x64.exe"'
	Switch GUICtrlRead($GUI_Compiler_IconFile)
		Case ""
			$Compiler_Script_x86 &= ' /icon "' & $FILE_icon & '"'
			$Compiler_Script_x64 &= ' /icon "' & $FILE_icon & '"'
		Case Else
			If FileExists(GUICtrlRead($GUI_Compiler_IconFile)) Then
				$Compiler_Script_x86 &= ' /icon "' & GUICtrlRead($GUI_Compiler_IconFile) & '"'
				$Compiler_Script_x64 &= ' /icon "' & GUICtrlRead($GUI_Compiler_IconFile) & '"'
			Else
				$Compiler_Script_x86 &= ' /icon "' & $FILE_icon & '"'
				$Compiler_Script_x64 &= ' /icon "' & $FILE_icon & '"'
			EndIf
	EndSwitch
	$Compiler_Script_x86 &= ' /x86'
	$Compiler_Script_x64 &= ' /x64'
	Switch GUICtrlRead($GUI_Compiler_Compression)
		Case "None"
			$Compiler_Script_x86 &= ' /comp 0'
			$Compiler_Script_x64 &= ' /comp 0'
		Case "Low"
			$Compiler_Script_x86 &= ' /comp 1'
			$Compiler_Script_x64 &= ' /comp 1'
		Case "Medium"
			$Compiler_Script_x86 &= ' /comp 2'
			$Compiler_Script_x64 &= ' /comp 2'
		Case "High"
			$Compiler_Script_x86 &= ' /comp 3'
			$Compiler_Script_x64 &= ' /comp 3'
		Case "Highest"
			$Compiler_Script_x86 &= ' /comp 4'
			$Compiler_Script_x64 &= ' /comp 4'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_IgnoreDirectives)
		Case $GUI_CHECKED
			$Compiler_Script_x86 &= ' /ignoredirectives'
			$Compiler_Script_x64 &= ' /ignoredirectives'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_UPXCompression)
		Case "Dont Compress"
			$Compiler_Script_x86 &= ' /nopack'
			$Compiler_Script_x64 &= ' /nopack'
		Case "Compress"
			$Compiler_Script_x86 &= ' /pack'
			$Compiler_Script_x64 &= ' /pack'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_AppType)
		Case "GUI"
			$Compiler_Script_x86 &= ' /gui'
			$Compiler_Script_x64 &= ' /gui'
		Case "Console"
			$Compiler_Script_x86 &= ' /console'
			$Compiler_Script_x64 &= ' /console'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_ExecutionLevel)
		Case "None"
			$Compiler_Script_x86 &= ' /execlevel none'
			$Compiler_Script_x64 &= ' /execlevel none'
		Case "AsInvoker"
			$Compiler_Script_x86 &= ' /execlevel asinvoker'
			$Compiler_Script_x64 &= ' /execlevel asinvoker'
		Case "Highest Avail"
			$Compiler_Script_x86 &= ' /execlevel highestavailable'
			$Compiler_Script_x64 &= ' /execlevel highestavailable'
		Case "Require Admin"
			$Compiler_Script_x86 &= ' /execlevel requireadministrator'
			$Compiler_Script_x64 &= ' /execlevel requireadministrator'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_Compatibility)
		Case "Windows Vista"
			$Compiler_Script_x86 &= ' /compatibility vista'
			$Compiler_Script_x64 &= ' /compatibility vista'
		Case "Windows 7"
			$Compiler_Script_x86 &= ' /compatibility win7'
			$Compiler_Script_x64 &= ' /compatibility win7'
		Case "Windows 8"
			$Compiler_Script_x86 &= ' /compatibility win8'
			$Compiler_Script_x64 &= ' /compatibility win8'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_Comment)
		Case ""
			$Compiler_Script_x86 &= ' /comments "Compiled with AutoIt Portable by zelles."'
			$Compiler_Script_x64 &= ' /comments "Compiled with AutoIt Portable by zelles."'
		Case Else
			$Compiler_Script_x86 &= ' /comments "' & GUICtrlRead($GUI_Compiler_Comment) & '"'
			$Compiler_Script_x64 &= ' /comments "' & GUICtrlRead($GUI_Compiler_Comment) & '"'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_CompanyName)
		Case ""
			$Compiler_Script_x86 &= ' /companyname "None"'
			$Compiler_Script_x64 &= ' /companyname "None"'
		Case Else
			$Compiler_Script_x86 &= ' /companyname "' & GUICtrlRead($GUI_Compiler_CompanyName) & '"'
			$Compiler_Script_x64 &= ' /companyname "' & GUICtrlRead($GUI_Compiler_CompanyName) & '"'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_Description)
		Case ""
			$Compiler_Script_x86 &= ' /filedescription "None"'
			$Compiler_Script_x64 &= ' /filedescription "None"'
		Case Else
			$Compiler_Script_x86 &= ' /filedescription "' & GUICtrlRead($GUI_Compiler_Description) & '"'
			$Compiler_Script_x64 &= ' /filedescription "' & GUICtrlRead($GUI_Compiler_Description) & '"'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_Copyright)
		Case ""
			$Compiler_Script_x86 &= ' /legalcopyright ' & @YEAR
			$Compiler_Script_x64 &= ' /legalcopyright ' & @YEAR
		Case Else
			$Compiler_Script_x86 &= ' /legalcopyright "' & GUICtrlRead($GUI_Compiler_Copyright) & '"'
			$Compiler_Script_x64 &= ' /legalcopyright "' & GUICtrlRead($GUI_Compiler_Copyright) & '"'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_Trademarks)
		Case ""
			$nothing = 0
		Case Else
			$Compiler_Script_x86 &= ' /legaltrademarks "' & GUICtrlRead($GUI_Compiler_Trademarks) & '"'
			$Compiler_Script_x64 &= ' /legaltrademarks "' & GUICtrlRead($GUI_Compiler_Trademarks) & '"'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_ProductName)
		Case ""
			$nothing = 0
		Case Else
			$Compiler_Script_x86 &= ' /productname "' & GUICtrlRead($GUI_Compiler_ProductName) & '"'
			$Compiler_Script_x64 &= ' /productname "' & GUICtrlRead($GUI_Compiler_ProductName) & '"'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_FileVersion)
		Case ""
			$Compiler_Script_x86 &= ' /fileversion "0.0.0.1"'
			$Compiler_Script_x64 &= ' /fileversion "0.0.0.1"'
		Case Else
			$Compiler_Script_x86 &= ' /fileversion "' & GUICtrlRead($GUI_Compiler_FileVersion) & '"'
			$Compiler_Script_x64 &= ' /fileversion "' & GUICtrlRead($GUI_Compiler_FileVersion) & '"'
	EndSwitch
	Switch GUICtrlRead($GUI_Compiler_ProductVersion)
		Case ""
			$Compiler_Script_x86 &= ' /productversion "3.3.12.0"'
			$Compiler_Script_x64 &= ' /productversion "3.3.12.0"'
		Case Else
			$Compiler_Script_x86 &= ' /productversion "' & GUICtrlRead($GUI_Compiler_ProductVersion) & '"'
			$Compiler_Script_x64 &= ' /productversion "' & GUICtrlRead($GUI_Compiler_ProductVersion) & '"'
	EndSwitch

	If GUICtrlRead($GUI_Compiler_x86) = $GUI_CHECKED Then
		RunWait($Compiler_Script_x86)
	EndIf
	If GUICtrlRead($GUI_Compiler_x64) = $GUI_CHECKED Then
		RunWait($Compiler_Script_x64)
	EndIf
	FileDelete($FILE_TEMP)
	GUIDelete($GUI_Compiler)
	MsgBox(0, "AIP Response", "The compiler is finished. Check script directory for files.")
EndFunc

Func Close_Compiler()
	GUIDelete($GUI_Compiler)
EndFunc

Func ImportCustomIncludes()
	If Not FileExists(@ScriptDir & "\custom-includes") Then DirCreate(@ScriptDir & "\custom-includes")
	Local $Importer = FileFindFirstFile(@ScriptDir & "\custom-includes\*.au3")
	Local $IncludeFile = ""
	While 1
		$IncludeFile = FileFindNextFile($Importer)
        If @error Then ExitLoop
		If FileExists($DIR_includes & "\" & $IncludeFile) Then ContinueLoop
		FileCopy(@ScriptDir & "\custom-includes\" & $IncludeFile, $DIR_includes & "\" & $IncludeFile)
		$AUTOIT_CODES &= '<' & $IncludeFile & '>'
	WEnd
EndFunc

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
