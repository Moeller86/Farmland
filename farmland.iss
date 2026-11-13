; FarmLand – installationsprogram (Inno Setup 6)
; Bygges af byg_installer.bat, som laver spillet med PyInstaller først og så kører Inno Setup på denne fil.
; Kan også bygges i hånden:  ISCC.exe /DAppVersion=1.17.0 farmland.iss

#ifndef AppVersion
  #define AppVersion "0.0.0"
#endif
#define AppName "FarmLand"
#define AppExe "FarmLand.exe"
#define SrcDir "installer_build\dist\FarmLand"

[Setup]
; AppId må aldrig ændres – så genkender Windows en ny version som en opdatering af den gamle
AppId={{F4F4471A-8ABF-4C67-8D6B-66F8A3CFC80F}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher=FarmLand
VersionInfoVersion={#AppVersion}
VersionInfoDescription={#AppName} installation
; installeres som standard kun for brugeren (kræver ikke administrator) – kan ændres til alle brugere i dialogen
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\{#AppExe}
UninstallDisplayName={#AppName}
SetupIconFile=farmland.ico
OutputDir=dist
OutputBaseFilename=FarmLand-Setup-{#AppVersion}
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
; spillet lukkes, hvis det kører, når en ny version installeres
CloseApplications=yes
RestartApplications=no

[Languages]
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "{#SrcDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion skipifsourcedoesntexist

[Icons]
Name: "{autoprograms}\{#AppName}"; Filename: "{app}\{#AppExe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon

[Run]
; installeres der for alle brugere (som administrator), åbnes Windows Firewall for multiplayer med det samme.
; Installeres der kun for brugeren, spørger Windows selv første gang, man er vært for et spil.
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""FarmLand"""; Flags: runhidden; Check: IsAdminInstallMode
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""FarmLand"" dir=in action=allow program=""{app}\{#AppExe}"" enable=yes"; Flags: runhidden; Check: IsAdminInstallMode
Filename: "{app}\{#AppExe}"; Description: "{cm:LaunchProgram,{#AppName}}"; Flags: nowait postinstall skipifsilent

[UninstallRun]
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""FarmLand"""; Flags: runhidden; Check: IsAdminInstallMode; RunOnceId: "FarmLandFirewall"

; Gemte spil og indstillinger (farmland_*.json) bliver liggende ved afinstallation, så de er der igen,
; hvis spillet installeres på ny. Kun fejlloggen og den midlertidige skrivetest ryddes op.
[UninstallDelete]
Type: files; Name: "{app}\farmland_fejl.txt"
Type: files; Name: "{app}\.farmland_skrivetest"
