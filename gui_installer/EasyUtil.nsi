;EasyUtil 2022
;(c) EasyUtil Corporation 2022

;DEVFRIENDS LICENSE >_<

;--------------------------------
;Include ModernUI pkg

  !include "MUI2.nsh"

;--------------------------------
;General

!define APPNAME "EasyUtil"
!define COMPANYNAME "EasySoftware"
!define DESCRIPTION "A simple utility for Windows"
!define VERSIONMAJOR 2
!define VERSIONMINOR 3
!define VERSIONBUILD 2
!define HELPURL "http://github.com/heewoonkim2020/EasyUtil"
!define UPDATEURL "http://github.com/heewoonkim2020/EasyUtil"
!define ABOUTURL "http://github.com/heewoonkim2020/EasyUtil"
!define INSTALLSIZE 28933

  ;Name and file
  Name "EasyUtil"
  OutFile "EasyUtil_v1_Setup.exe"
  Unicode True

  ;Default installation folder
  InstallDir "C:\Program Files\EasyUtil\"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\EasyUtil" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "C:\Users\heewo\PycharmProjects\EasyUtil\gui_installer\license.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

!macro VerifyUserIsAdmin
UserInfo::GetAccountType
pop $0
${If} $0 != "admin" ;Require admin rights on NT4+
        messageBox mb_iconstop "An error occurred. Please try again."
        setErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
        quit
${EndIf}
!macroend

function .onInit
	setShellVarContext all
	!insertmacro VerifyUserIsAdmin
functionEnd

BrandingText "EasySoftware 2022"

Section "Core Files" SecCore

  SetOutPath "$INSTDIR"

  ;ADD YOUR OWN FILES HERE...

  ;Store installation folder
  WriteRegStr HKCU "Software\EasyUtil" "" $INSTDIR

  ;Create uninstaller
  WriteUninstaller $INSTDIR\uninstaller.exe
  createDirectory "$SMPROGRAMS\EasyUtil"
  createShortCut "$SMPROGRAMS\EasyUtil\EUtil Uninstall.lnk" "$INSTDIR\uninstaller.exe"

  File "C:\Users\heewo\PycharmProjects\EasyUtil\install_res\gui\v1\logo.ico"

  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayName" "EasyUtil"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "UninstallString" "$INSTDIR\uninstaller.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "InstallLocation" $\"$INSTDIR$\"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayIcon" "$\"$INSTDIR\logo.ico$\""
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "Publisher" "${COMPANYNAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "HelpLink" "'${HELPURL}$\'"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "URLUpdateInfo" "${UPDATEURL}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "URLInfoAbout" "${ABOUTURL}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayVersion" "${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "VersionMajor" ${VERSIONMAJOR}
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "VersionMinor" ${VERSIONMINOR}
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "NoRepair" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "EstimatedSize" ${INSTALLSIZE}

  createDirectory "$INSTDIR\temp"
  SetOutPath "$INSTDIR\temp"
  File "C:\Users\heewo\PycharmProjects\EasyUtil\install_res\gui\v1\assets\*"

  DetailPrint "Extracting: ./msiguiv/sinit/envprepare.exe"
  Sleep 3000

  createDirectory "$INSTDIR\bin"
  SetOutPath "$INSTDIR\bin"
  File "C:\Users\heewo\PycharmProjects\EasyUtil\install_res\gui\v1\bin\*"

  createDirectory "$INSTDIR\booltrue_false"
  SetOutPath "$INSTDIR\booltrue_false"
  File "C:\Users\heewo\PycharmProjects\EasyUtil\install_res\gui\v1\booltrue_false\*"

  DetailPrint "Preparing EUtil for first setup"
  Sleep 2000
  DetailPrint "Add exception to WindowsDefender"
  Sleep 1000
  DetailPrint "Add exception to AvastAntivirus"
  Sleep 900

  DetailPrint "Completed anti-malware action"
  Sleep 1000

  createDirectory "$INSTDIR\guitk"
  SetOutPath "$INSTDIR\guitk"
  File "C:\Users\heewo\PycharmProjects\EasyUtil\install_res\gui\v1\guitk\*"

SectionEnd

Section "Optional Fun" SecFun

  SetOutPath "$INSTDIR\Fun"

  ;ADD YOUR OWN FILES HERE...

  ;Store fun install key
  WriteRegStr HKCU "Software\EasyUtil\Fun" "instdir" "installationdirdef"

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecCore ${LANG_ENGLISH} "The core files of EasyUtil. Installation won't take effect if unchecked."
  LangString DESC_SecFun ${LANG_ENGLISH} "The optional files that include fun applications."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecCore} $(DESC_SecCore)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecFun} $(DESC_SecFun)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller section

function un.onInit
	SetShellVarContext all

	#Verify the uninstaller - last chance to back out
	MessageBox MB_OKCANCEL "Permanantly remove ${APPNAME}?" IDOK next
		Abort
	next:
	!insertmacro VerifyUserIsAdmin
functionEnd

Section "Uninstall"

  delete "$SMPROGRAMS\EasyUtil\EUtil Uninstall.lnk"
  RMDir "$SMPROGRAMS/EasyUtil"

  Delete "$INSTDIR\*"
  RMDir "$INSTDIR\*"

  Delete "$INSTDIR\Fun\*"
  Delete "$INSTDIR\temp\*"
  Delete "$INSTDIR\booltrue_false\*"
  Delete "$INSTDIR\bin\*"
  Delete "$INSTDIR\guitk\*"

  RMDir "$INSTDIR\Fun"
  RMDir "$INSTDIR\temp"
  RMDir "$INSTDIR\booltrue_false"
  RMDir "$INSTDIR\bin"
  RMDir "$INSTDIR\guitk"

  RMDir "$INSTDIR"

  DeleteRegKey HKCU "Software\EasyUtil\Fun"
  DeleteRegKey HKCU "Software\EasyUtil"

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}"

SectionEnd
