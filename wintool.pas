unit WinTool;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls,  EditBtn,  GlobalInfo,GetPath,
  registry ;

function CheckFramework: string;
function CheckFramework4Client: string;
function CheckFramework4Full: string;
function CheckGtk: string;
function CheckMono: string;
function CheckMoscrifIde( fileName : string): Boolean;
procedure WriteLog ( fileName : string) ;

Const
  netLocation = 'SOFTWARE\Microsoft\NET Framework Setup\NDP\';
  gtkLocation = 'SOFTWARE\Novell\GtkSharp\';
  monoLocation = 'SOFTWARE\Novell\Mono';

var
   logText : string;
   reg:TRegistry;

implementation


function CheckFramework4Client: string;
var
   reg:TRegistry;
   sp,inst : Integer;
  Const
    SubKey = 'v4\Client\';
begin
     reg:=TRegistry.Create;
     with reg do begin
           reg.RootKey := HKEY_LOCAL_MACHINE;
          try
              if reg.OpenKey(netLocation+SubKey, False) then begin
                 inst := reg.ReadInteger('Install');
                 if ((inst = 1)) then begin
                    CheckFramework4Client := '';
                 end
                  else begin
                     CheckFramework4Client :='Framework 4 MISSSING ; ' ;
                 end;
             end
             else begin
                  CheckFramework4Client :='Framework 4 ' ;
             end;
          finally
              reg.Free;
          end;
     end;
end;


function CheckFramework4Full: string;
var
   reg:TRegistry;
   sp,inst : Integer;
  Const
    SubKey = 'v4\\Full\';
begin
     reg:=TRegistry.Create;
     with reg do begin
           reg.RootKey := HKEY_LOCAL_MACHINE;
          try
              if reg.OpenKey(netLocation+SubKey, False) then begin
                 inst := reg.ReadInteger('Install');
                 if ((inst = 1)) then begin
                    CheckFramework4Full := '';
                 end
                  else begin
                     CheckFramework4Full :='Framework 4 MISSSING ; ' ;
                 end;
             end
             else begin
                  CheckFramework4Full :='Framework 4 ' ;
             end;
          finally
              reg.Free;
          end;
     end;
end;

procedure WriteLog (fileName : string ) ;

Var
 file1:TextFile;
 appPath ,personalFolder: string;
begin

    personalFolder := GetSpecialFolder($0005) ;
    appPath := personalFolder + DirectorySeparator+ '.Moscrif';//+ DirectorySeparator;//+fileName;
    If Not DirectoryExists(appPath) then
       If Not CreateDir (appPath) Then
          Exit;

   appPath := appPath +DirectorySeparator+ fileName;

   AssignFile(file1,appPath);
   Try
      Rewrite (file1);
      Writeln(file1,logText);
   Finally
      CloseFile(file1);
   End;
End;

function CheckMoscrifIde( fileName : string): Boolean;
begin
  if(FileExists(fileName) = False) then
  begin
           logText:= logText  + #13#10 + 'MoscrifIde corrupted!';
           CheckMoscrifIde := False;
  end else
      begin
           logText:= logText  + #13#10 + 'MoscrifIde OK!';
           CheckMoscrifIde := True;
      end;

    WriteLog('moscrif-ide-start.log');
end;


function CheckFramework: string;
var
   reg:TRegistry;
   sp,inst : Integer;
  Const
    SubKey = 'v3.5\';
begin
     logText:= logText  + #13#10 + 'Start Check Framework';
     reg:=TRegistry.Create;
     with reg do begin
           //reg.RootKey := HKEY_LOCAL_MACHINE;
           reg.RootKey:=-2147483646;
          try
                logText:= logText  + #13#10 + netLocation+SubKey;
              if reg.OpenKey(netLocation+SubKey, False) then begin
                 logText:= logText  + #13#10 + 'Open Registry.';
                 sp :=1;//:= reg.ReadInteger('SP');
                 inst := reg.ReadInteger('Install');
                 if ((inst = 1) and (sp=1)) then begin
                    logText:= logText  + #13#10 + 'Chceck Framework 3.5 - Ok .';
                    CheckFramework := '';//'Framework 3.5 is OK; SP1 is OK' ;
                 end
                  else if ((inst = 1) and (sp=0)) then begin
                     logText:= logText  + #13#10 + 'Framework 3.5 is OK; SP1 MISSSING';
                     CheckFramework :='Framework 3.5 is OK; SP1 MISSSING' ;
                 end else begin
                      logText:= logText  + #13#10 + 'Framework 3.5 MISSSING OK;';
                     CheckFramework :='Framework 3.5 MISSSING OK; SP1 MISSSING' ;
                 end;
             end
             else begin
                  logText:= logText  + #13#10 + 'Framework 3.5 MISSSING - reg not open;';
                  CheckFramework :='Framework 3.5 and SP1 is not instaled' ;
             end;
          finally
              reg.Free;
              WriteLog('moscrif-ide-start.log');
          end;
     end;
end;

function CheckMono: string;
var
   reg:TRegistry;
   sp: String;
   iMajor,iMinor :Integer ;
   major,minor : String;
begin
   logText:= logText  + #13#10 + 'Start Check Mono';
     reg:=TRegistry.Create;
     with reg do begin
          // reg.RootKey := HKEY_LOCAL_MACHINE;
             reg.RootKey:=-2147483646;
            logText:= logText  + #13#10 + monoLocation;
          try
              if reg.OpenKey(monoLocation, False) then begin
                   logText:= logText  + #13#10 + 'Open Registry.';

                 sp := reg.ReadString('DefaultCLR');

                 if( Trim(sp) <> '' ) then begin
                    logText:= logText  + #13#10 + 'Chceck Mono Unknow version Ok .';
                    iMajor := Pos('.',sp);
                     major := Copy(sp, 1, iMajor-1 );
                     Delete(sp,1, iMajor);

                     iMinor:= Pos('.',sp );
                      minor := Copy(sp, 1, iMinor-1 );
                      if((StrToInt(major) >= 2) and ((StrToInt(minor) >= 8))) then
                      //2
                      begin
                           logText:= logText  + #13#10 + 'Chceck Mono 2.8 - Ok .';
                           CheckMono := '';//'Mono ' + major+'.'+minor + ' OK';
                      end else begin
                            logText:= logText  + #13#10 + 'Mono not instaled or is old.';
                           CheckMono :='Mono not instaled or is old' ;
                      end;

                 end else begin
                           logText:= logText  + #13#10 + 'Mono not instaled or is old. -2';
                           CheckMono :='Mono not instaled' ;
                 end;
             end else begin
                  logText:= logText  + #13#10 + 'Mono not instaled. Reg not open.';
                  CheckMono :='Mono not instaled' ;
             end;
          finally
              reg.Free;
              WriteLog('moscrif-ide-start.log');
          end;
     end;
end;

function CheckGtk: string;
var
   sp,inst : String;
   iMajor,iMinor :Integer ;
   major,minor : String;
   //SOFTWARE\Novell\GtkSharp\
begin
     logText:= logText  + #13#10 + 'Start Check Gtk';
     reg:=TRegistry.Create;
     with reg do begin
          // reg.RootKey := HKEY_LOCAL_MACHINE;
             reg.RootKey:=-2147483646;
          try
              logText:= logText  + #13#10 + gtkLocation+'Version\';
              if OpenKey(gtkLocation+'Version\', False) then begin
                   logText:= logText  + #13#10 + 'Open Registry.';
                 sp := reg.ReadString('');
                 if( Trim(sp) <> '' ) then begin
                    logText:= logText  + #13#10 + 'Chceck GTK Unknow version Ok .';
                    iMajor := Pos('.',sp);
                     major := Copy(sp, 1, iMajor-1 );
                    // CheckGtk := major ;
                     Delete(sp,1, iMajor);

                     iMinor:= Pos('.',sp );
                      minor := Copy(sp, 1, iMinor-1 );
                      if((StrToInt(major) >= 2) and ((StrToInt(minor) >= 12))) then
                      begin
                            logText:= logText  + #13#10 + 'Chceck GTK 2.12 Ok .';
                           CheckGtk := '';//'GtkSharp ' + major+'.'+minor + ' OK';
                      end else begin
                          logText:= logText  + #13#10 + 'GTK Wrong version.';
                           CheckGtk :='GtkSharp not instaled or is old' ;
                      end;

                 end else begin
                           logText:= logText  + #13#10 + 'GtkSharp not instaled';
                           CheckGtk :='GtkSharp not instaled' ;
                 end;

                 inst := reg.ReadString('InstallFolder');

             end
             else begin
                  logText:= logText  + #13#10 + 'GtkSharp not instaled - Reg not open';
                  CheckGtk :='GtkSharp not instaled' ;
             end;
          finally
              reg.Free;
              WriteLog('moscrif-ide-start.log');
          end;
     end;

end;

end.

