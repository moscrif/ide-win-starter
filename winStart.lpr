program winStart;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,LResources , SplashScreenForm, GlobalInfo, WinTool, Dialog, GetPath;

{$R *.res}

begin
  {$I moscrif-ide.lrs}
  Application.Title:='Moscrif-Ide Starter';
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  {if Assigned(Form1) then
    Form1.RunTest();

  splashForm := TForm1.Create(nil);
  splashForm.Show;  }

  Application.Run;

end.

