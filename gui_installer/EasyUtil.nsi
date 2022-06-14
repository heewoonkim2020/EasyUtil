;EasyUtil 2022
;(c) EasyUtil Corporation 2022

;DEVFRIENDS LICENSE >_<

;--------------------------------
;Include ModernUI pkg

  !include "MUI2.nsh"

;--------------------------------
;General

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
  WriteUninstaller $INSTDIR\uninstaller.exe
  createDirectory "$SMPROGRAMS\EasyUtil"
  createShortCut "$SMPROGRAMS\EasyUtil\EUtil Uninstall.lnk" "$INSTDIR\uninstaller.exe"
  createDirectory "$INSTDIR\temp"
  inetc::get "https://github.com/heewoonkim2020/EasyUtil/raw/main/install_res/gui/v1/assets/thumbnail1.jpg" "$INSTDIR\temp\thumb1.jpg"
  createDirectory "$INSTDIR\bin"
  inetc::get "https://github.com/heewoonkim2020/EasyUtil/raw/main/install_res/gui/v1/bin/safesearch.txt" "$INSTDIR\bin\safesearch.txt"
  createDirectory "$INSTDIR\booltrue_false"
  inetc::get "https://github.com/heewoonkim2020/EasyUtil/raw/main/install_res/gui/v1/booltrue_false/iffalse" "$INSTDIR\booltrue_false\iffalse"
  inetc::get "https://github.com/heewoonkim2020/EasyUtil/raw/main/install_res/gui/v1/booltrue_false/iftrue" "$INSTDIR\booltrue_false\iftrue"

SectionEnd

Section "Optional Fun" SecFun

  SetOutPath "$INSTDIR\Fun"

  ;ADD YOUR OWN FILES HERE...

  ;Store fun install key
  WriteRegStr HKCU "Software\EasyUtil\Fun" "instdir" "e"

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

Section "Uninstall"

  delete "$SMPROGRAMS\EasyUtil\EUtil Uninstall.lnk"
  RMDir "$SMPROGRAMS/EasyUtil"

  Delete "$INSTDIR\*"
  RMDir "$INSTDIR\*"

  Delete "$INSTDIR\Fun\*"
  Delete "$INSTDIR\temp\*"
  Delete "$INSTDIR\booltrue_false\*"
  Delete "$INSTDIR\bin\*"

  RMDir "$INSTDIR\Fun"
  RMDir "$INSTDIR\temp"
  RMDir "$INSTDIR\booltrue_false"
  RMDir "$INSTDIR\bin"

  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\EasyUtil\Fun\instdir"
  DeleteRegKey /ifempty HKCU "Software\EasyUtil\Fun"
  DeleteRegKey /ifempty HKCU "Software\EasyUtil"

SectionEnd
