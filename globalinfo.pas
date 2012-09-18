unit GlobalInfo;

{$mode objfpc}{$H+}

interface

uses
 Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls,  EditBtn,
  registry
 {$IFDEF MSWINDOWS}
         ,windows
 {$ENDIF}
 ;

function GetDefaultTargetCPU: string;
function GetDefaultTargetOS: string;

implementation

function GetDefaultTargetOS: string;
begin
  Result:=lowerCase({$I %FPCTARGETOS%});
end;

function GetDefaultTargetCPU: string;
begin
  Result:=lowerCase({$I %FPCTARGETCPU%});
end;

function OSVersion: String;
 var
  osErr: integer;
  response: longint;
begin
  {$IFDEF LCLcarbon}
  OSVersion := 'Mac OS X 10.';
  {$ELSE}
  {$IFDEF Linux}
  OSVersion := 'Linux Kernel ';
  {$ELSE}
  {$IFDEF UNIX}
  OSVersion := 'Unix ';
  {$ELSE}
  {$IFDEF WINDOWS}
 { if WindowsVersion = wv95 then OSVersion := 'Windows 95 '
   else if WindowsVersion = wvNT4 then OSVersion := 'Windows NT v.4 '
   else if WindowsVersion = wv98 then OSVersion := 'Windows 98 '
   else if WindowsVersion = wvMe then OSVersion := 'Windows ME '
   else if WindowsVersion = wv2000 then OSVersion := 'Windows 2000 '
   else if WindowsVersion = wvXP then OSVersion := 'Windows XP '
   else if WindowsVersion = wvServer2003 then OSVersion := 'Windows Server 2003 '
   else if WindowsVersion = wvVista then OSVersion := 'Windows Vista '
   else if WindowsVersion = wv7 then OSVersion := 'Windows 7 '
   else OSVersion:= 'Windows ';  }
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
end;

end.

