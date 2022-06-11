;NSIS Modern User Interface
;Welcome/Finish Page Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Name and file
  Name "EasyUtil"
  OutFile "EasyUtil_v1_Setup.exe"
  Unicode True

  ;Default installation folder
  InstallDir "$LOCALAPPDATA\EasyUtil"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\EasyUtil" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

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

Section "Core Files" SecCore

  SetOutPath "$INSTDIR"

  ;ADD YOUR OWN FILES HERE...

  ;Store installation folder
  WriteRegStr HKCU "Software\EasyUtil" "" $INSTDIR

  ;Create uninstaller
  ;NSISdl::download "https://github.com/heewoonkim2020/EasyUtil/raw/main/installer_archives/archive1.zip" "$INSTDIR\eutil.zip"
  ;Pop $0
  ;${If} $0 == "success"
  ;  MessageBox mb_iconstop "Warning: Success, however used HTTP."
  ;${Else}
  ;  MessageBox mb_iconstop "Error: $0" ;Show cancel/error message
  ;${EndIf}
  inetc::get "https://github.com/heewoonkim2020/EasyUtil/raw/main/installer_archives/archive1.zip" "$INSTDIR\eutil.zip"

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecCore ${LANG_ENGLISH} "The core files of EasyUtil. Installation won't take effect if unchecked."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecCore} $(DESC_SecCore)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller section

Section "Uninstall"

  Delete "$INSTDIR\*"
  RMDir "$INSTDIR\*"

  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\EasyUtil"

SectionEnd
