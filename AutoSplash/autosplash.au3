;Autorun Splash Screen

Dim $ConfigFile ;Configuration File
Dim $ImageFile ;Image to be shown.  Must be BMP,GIF or JPG
Dim $ImageWidth ;Width of the image to display in pixels
Dim $ImageHeight ;Height of image in pixels
Dim $Title ;Title to be displayed
Dim $ShowTime ;Length of time to display image in seconds
Dim $ShowTitle ;Determine whether or not to display the title
Dim $ShowTitleSetting ;Setting for ShowTitle

$ConfigFile = _GetConfigFile("autosplash.ini",True)

If $ConfigFile = "Error" Then Exit

$ImageFile = IniRead($ConfigFile,"General","ImageFile","SplashImage.jpg")

If StringMid($ImageFile,2,1)<>":" and StringMid($ImageFile,2,1)<>"\" Then
	$ImageFile = @ScriptDir & "\" & $ImageFile
EndIf

If Not FileExists($ImageFile) Then Exit

$ImageHeight = IniRead($ConfigFile,"General","ImageHeight",68)
$ImageWidth = IniRead($ConfigFile,"General","ImageWidth",587)
$Title = IniRead($ConfigFile,"General","Title","Daily Cup of Tech")
$ShowTime = IniRead($ConfigFile,"General","ShowTime",2)
$ShowTitle = IniRead($ConfigFile,"General","ShowTitle",False)

If $ShowTitle = True Then
	$ShowTitleSetting = -1
Else
	$ShowTitleSetting = 1
EndIf


SplashImageOn($Title,$ImageFile,$ImageWidth,$ImageHeight,-1,-1,$ShowTitleSetting)
Sleep($ShowTime * 1000)
SplashOff()

#region Functions
Func _GetConfigFile($filename,$silent = False)
	Local $configfilename
	$configfilename = @ScriptDir & "\" & $filename

	If Not FileExists($configfilename) Then
		If Not $silent Then
			MsgBox(16,"File Missing","The file " & $filename & " is not available." & @CRLF & "Please ensure that it is located in the " & @ScriptDir & " directory." & @CRLF & "The application will now exit.")
			Exit
		EndIf
		SetError(1)
		Return "Error"
	EndIf
	Return $configfilename
EndFunc
#endregion