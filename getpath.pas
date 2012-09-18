unit GetPath;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils
  {$IFDEF MSWINDOWS}
         ,windows
 {$ENDIF} ;

function GetSpecialFolder(nFolder: integer): string;
implementation

function GetSpecialFolder(nFolder: integer): string;
var pidl: PItemIDList;
    path: Array[0..MAX_PATH] of char;
    returnPath : string;
begin
     returnPath :=  SysUtils.GetEnvironmentVariable('HOME');
     {$IFDEF MSWINDOWS}
             SHGetSpecialFolderLocation(0, nFolder, pidl);
             SHGetPathFromIDList(pidl, path);
             returnPath := path;
     {$ENDIF} ;
              GetSpecialFolder :=returnPath;

end;
  {
  {$EXTERNALSYM CSIDL_FAVORITES}
        CSIDL_FAVORITES = $0006;
        {$EXTERNALSYM CSIDL_MYDOCUMENTS} // logical "My Documents" desktop icon
        CSIDL_MYDOCUMENTS = $000C;
        {$EXTERNALSYM CSIDL_MYMUSIC} // "My Music" folder
        CSIDL_MYMUSIC = $000D;
        {$EXTERNALSYM CSIDL_MYVIDEO} // "My Videos" folder
        CSIDL_MYVIDEO = $000E;
        {$EXTERNALSYM CSIDL_LOCAL_APPDATA}
        CSIDL_LOCAL_APPDATA = $001C;
        {$EXTERNALSYM CSIDL_COMMON_APPDATA}
        CSIDL_COMMON_APPDATA = $0023;
        {$EXTERNALSYM CSIDL_WINDOWS}
        CSIDL_WINDOWS = $0024;
        {$EXTERNALSYM CSIDL_SYSTEM}
        CSIDL_SYSTEM = $0025;
        {$EXTERNALSYM CSIDL_PROGRAM_FILES}
        CSIDL_PROGRAM_FILES = $0026;
        {$EXTERNALSYM CSIDL_PROFILE}
        CSIDL_PROFILE = $0028;
        {$EXTERNALSYM CSIDL_PROGRAM_FILES_COMMON}
        CSIDL_PROGRAM_FILES_COMMON = $002B;
        {$EXTERNALSYM CSIDL_COMMON_TEMPLATES}
        CSIDL_COMMON_TEMPLATES = $002D;
        {$EXTERNALSYM CSIDL_COMMON_DOCUMENTS}
        CSIDL_COMMON_DOCUMENTS = $002E;
        {$EXTERNALSYM CSIDL_PROFILES}
        CSIDL_PROFILES = $003E;
        {$IFDEF LCL}
        {$EXTERNALSYM CSIDL_DESKTOP} // <desktop>
        CSIDL_DESKTOP = $0000;
        {$EXTERNALSYM CSIDL_INTERNET} // Internet Explorer (icon on desktop)
        CSIDL_INTERNET = $0001;
        {$EXTERNALSYM CSIDL_PROGRAMS} // Start Menu\Programs
        CSIDL_PROGRAMS = $0002;
        {$EXTERNALSYM CSIDL_CONTROLS} // My Computer\Control Panel
        CSIDL_CONTROLS = $003;
        {$EXTERNALSYM CSIDL_PRINTERS} // My Computer\Printers
        CSIDL_PRINTERS = $004;
        {$EXTERNALSYM CSIDL_PERSONAL} // My Documents
        CSIDL_PERSONAL = $0005;
        {$EXTERNALSYM CSIDL_STARTUP} // Start Menu\Programs\Startup
        CSIDL_STARTUP = $0007;
        {$EXTERNALSYM CSIDL_RECENT} // <user name>\Recent
        CSIDL_RECENT = $0008;
        {$EXTERNALSYM CSIDL_SENDTO} // <user name>\SendTo
        CSIDL_SENDTO = $0009;
        {$EXTERNALSYM CSIDL_BITBUCKET} // <desktop>\Recycle Bin
        CSIDL_BITBUCKET = $000A;
        {$EXTERNALSYM CSIDL_STARTMENU} // <user name>\Start Menu
        CSIDL_STARTMENU = $000B;
        {$EXTERNALSYM CSIDL_DESKTOPDIRECTORY} // <user name>\Desktop
        CSIDL_DESKTOPDIRECTORY = $0010;
        {$EXTERNALSYM CSIDL_DRIVES} // My Computer
        CSIDL_DRIVES = $0011;
        {$EXTERNALSYM CSIDL_NETWORK} // Network Neighborhood (My Network Places)
        CSIDL_NETWORK = $0012;
        {$EXTERNALSYM CSIDL_NETHOOD} // <user name>\nethood
        CSIDL_NETHOOD = $00013;
        {$EXTERNALSYM CSIDL_FONTS} // windows\fonts
        CSIDL_FONTS = $0014;
        {$EXTERNALSYM CSIDL_TEMPLATES}
        CSIDL_TEMPLATES = $0015;
        {$EXTERNALSYM CSIDL_COMMON_STARTMENU} // All Users\Start Menu
        CSIDL_COMMON_STARTMENU = $0016;
        {$EXTERNALSYM CSIDL_COMMON_PROGRAMS} // All Users\Start Menu\Programs
        CSIDL_COMMON_PROGRAMS = $0017;
        {$EXTERNALSYM CSIDL_COMMON_STARTUP} // All Users\Startup
        CSIDL_COMMON_STARTUP = $0018;
        {$EXTERNALSYM CSIDL_COMMON_DESKTOPDIRECTORY} // All Users\Desktop
        CSIDL_COMMON_DESKTOPDIRECTORY = $0019;
        {$EXTERNALSYM CSIDL_APPDATA} // <user name>\Application Data
        CSIDL_APPDATA = $001A;
        {$EXTERNALSYM CSIDL_PRINTHOOD}  // <user name>\PrintHood
        CSIDL_PRINTHOOD = $001B;
        {$EXTERNALSYM CSIDL_ALTSTARTUP} // non localized startup
        CSIDL_ALTSTARTUP = $001D;
        {$EXTERNALSYM CSIDL_COMMON_ALTSTARTUP} // non localized common startup
        CSIDL_COMMON_ALTSTARTUP = $001E;
        {$EXTERNALSYM CSIDL_COMMON_FAVORITES}
        CSIDL_COMMON_FAVORITES = $001F;
        {$EXTERNALSYM CSIDL_COMMON_MUSIC} // All Users\My Music
        CSIDL_COMMON_MUSIC = $0035;
        {$EXTERNALSYM CSIDL_COMMON_PICTURES} // All Users\My Pictures
        CSIDL_COMMON_PICTURES = $0036;
        {$EXTERNALSYM CSIDL_COMMON_VIDEO} // All Users\My Video
        CSIDL_COMMON_VIDEO = $0037;

  }
end.

end.

