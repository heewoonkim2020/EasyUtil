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
!define VERSIONBUILD 3
!define HELPURL "http://github.com/heewoonkim2020/EasyUtil"
!define UPDATEURL "http://github.com/heewoonkim2020/EasyUtil"
!define ABOUTURL "http://github.com/heewoonkim2020/EasyUtil"
!define INSTALLSIZE 28933

  ;Name and file
  Name "EasyUtil"
  OutFile "EasyUtil_Setup.exe"
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
        messageBox mb_iconstop "Security error. Click OK to reload."
        setErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
        quit
${EndIf}
!macroend

function .onInit
	setShellVarContext all
	!insertmacro VerifyUserIsAdmin
functionEnd

BrandingText "EasySoftware 2022"

Icon "C:\Users\heewo\PycharmProjects\EasyUtil\install_res\gui\v1\logo.ico"

Section "-!Core Files" SecCore

  SetOutPath "$INSTDIR"

  ;Store installation folder
  WriteRegStr HKCU "Software\EasyUtil" "" $INSTDIR
  WriteRegDWORD HKCU "Software\EasyUtil" "AutoUpdate" 1
  WriteRegDWORD HKCU "Software\EasyUtil" "InstallerAutoUpdate" 1

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
  Sleep 500
  DetailPrint "Add exception to WindowsDefender"
  Sleep 500
  DetailPrint "Add exception to AvastAntivirus"
  Sleep 200

  DetailPrint "Windows C++ Redistributable: Downloading"
  Sleep 400
  DetailPrint "Windows C++ Redistributable: Installing"
  Sleep 300
  DetailPrint "DreamyMelo Java: Installed!"
  Sleep 100

  createDirectory "$INSTDIR\guitk"
  SetOutPath "$INSTDIR\guitk"
  File "C:\Users\heewo\PycharmProjects\EasyUtil\install_res\gui\v1\guitk\*"

SectionEnd

SectionGroup "!Security" secgroupSecurity

  Section "Avast EPK Portable" SecSecurityEPK

    createDirectory "$INSTDIR\Security"
    SetOutPath "$INSTDIR\Security"

    File "C:\Users\heewo\PycharmProjects\EasyUtil\install_res\gui\v1\Security\avast_portable_modules.epk"

  SectionEnd

  Section "VA Modules" SecSecurityVA

    createDirectory "$INSTDIR\Security\VA"
    SetOutPath "$INSTDIR\Security\VA"

    File "C:\Users\heewo\PycharmProjects\EasyUtil\install_res\gui\v1\Security\va1.eva"

  SectionEnd

  Section /o "Avast Antivirus Application" SecSecurityAvastApp

    createDirectory "$INSTDIR\Security" ;Only if folder doesnt exist
    SetOutPath "$INSTDIR\Security"

    File "C:\Users\heewo\PycharmProjects\EasyUtil\install_res\gui\v1\Security\avastinstaller.zip"

  SectionEnd

SectionGroupEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecCore ${LANG_ENGLISH} "The core files of EasyUtil. Installation won't take effect if unchecked."
  LangString DESC_SecSecurityEPK ${LANG_ENGLISH} "Avast's portable EPK files."
  LangString DESC_SecSecurityVA ${LANG_ENGLISH} "Enhanced Avast VA Modules. Recommended."
  LangString DESC_SecSecurity ${LANG_ENGLISH} "Prevents exploits and protects your PC. Very recommended."
  LangString DESC_SecSecurityAvastApp ${LANG_ENGLISH} "Not recommended. Installs Avast completely!"

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecCore} $(DESC_SecCore)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecSecurityEPK} $(DESC_SecSecurityEPK)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecSecurityVA} $(DESC_SecSecurityVA)
    !insertmacro MUI_DESCRIPTION_TEXT ${secgroupSecurity} $(DESC_SecSecurity)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecSecurityAvastApp} $(DESC_SecSecurityAvastApp)
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
  Delete "$INSTDIR\Security\*"
  Delete "$INSTDIR\Security\VA\*"

  RMDir "$INSTDIR\Fun"
  RMDir "$INSTDIR\temp"
  RMDir "$INSTDIR\booltrue_false"
  RMDir "$INSTDIR\bin"
  RMDir "$INSTDIR\guitk"
  RMDir "$INSTDIR\Security\VA"
  RMDir "$INSTDIR\Security"

  RMDir "$INSTDIR"

  DeleteRegKey HKCU "Software\EasyUtil\Fun"
  DeleteRegKey HKCU "Software\EasyUtil"

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}"

SectionEnd
