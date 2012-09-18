unit SplashScreenForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, eventlog, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, LCLIntf,WinTool,StdCtrls,Dialog,LResources ;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Process2: TProcess;
    ReadOutputIdleTimer: TIdleTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ReadOutputIdleTimerTimer(Sender: TObject);
  private
    //FStartTicks: int64;
    FOKToClose: boolean;
    { private declarations }
  public
    //property OKToClose: boolean read FOKToClose write FOKToClose;
    { public declarations }
  end;


var
  Form1: TForm1; 

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
    //FStartTicks := GetTickCount;
    //OKToClose:= True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     Form1:= nil;
end;

procedure TForm1.FormShow(Sender: TObject);
var
   message,messageMono,message4C,message4F,filePath, parameters : string;
   errorDialog : TErrorDialog;
   i : Integer ;
begin
  errorDialog := TErrorDialog.Create(nil);
  //FStartTicks := GetTickCount;
  //OKToClose:= False;
  {$IFDEF WINDOWS}

  message:=CheckFramework;
  if(message <> '') then begin

   // message4F:=CheckFramework4Full;
    // if(message4F <> '') then begin
       //message4C:=CheckFramework4Client;
        //if(message4C <> '') then begin
          messageMono:=CheckMono;
          if(messageMono <> '') then begin
                     errorDialog.ErrorMessage:= 'Framework 3.5 or Mono 2.8 not instaled. Please, download .Net Framework 3.5 or "Mono for Windows, Gtk#, and XSP".';
                     errorDialog.LinkMessage:= 'http://www.go-mono.com/mono-downloads/download.html';
                     errorDialog.LinkMessage2:= 'http://www.microsoft.com/download/en/default.aspx';
                    if errorDialog.ShowModal = mrOK then begin

                    end ;
                    self.Close;
                    Exit;
          end;

       // end;

     //end;
           {  errorDialog.ErrorMessage:= message;
             errorDialog.LinkMessage:= 'http://www.microsoft.com/download/en/search.aspx?q=Microsoft+.NET+Framework+3.5+SP1';
            if errorDialog.ShowModal = mrOK then begin

            end ;
            self.Close;
             Exit; }
  end;

 { message:=CheckMono;
  if(message <> '') then begin
             errorDialog.ErrorMessage:= message+ '. Please, download "Mono for Windows, Gtk#, and XSP".';
             errorDialog.LinkMessage:= 'http://www.go-mono.com/mono-downloads/download.html';
            if errorDialog.ShowModal = mrOK then begin

            end ;
            self.Close;
            Exit;
  end; }

  message:=CheckGtk;
  if(message <> '') then begin
             errorDialog.ErrorMessage:= message+'. Please, download "Gtk# for .NET".';
             errorDialog.LinkMessage:= 'http://www.go-mono.com/mono-downloads/download.html';
            if errorDialog.ShowModal = mrOK then begin

            end ;
            self.Close;
            Exit;
  end;
   {$ENDIF}
  filePath:= ExtractFilePath(ParamStr(0));
  filePath:= filePath + PathDelim + 'moscrif-ide-app.exe';

  {if(FileExists(filePath) = False) then
  begin
       errorDialog.ErrorMessage:= 'Moscrif SDK is corupted. Please, download Moscrif SDK.';
       errorDialog.LinkMessage:= 'http://moscrif.com/download';
       if errorDialog.ShowModal = mrOK then begin

       end ;
       self.Close;
       Exit;
  end;   }
  if(CheckMoscrifIde(filePath) = False) then
  begin
    errorDialog.ErrorMessage:= 'Moscrif SDK is corupted. Please, download Moscrif SDK.';
    errorDialog.LinkMessage:= 'http://moscrif.com/download';
    if errorDialog.ShowModal = mrOK then begin

    end ;
    self.Close;
    Exit;
  end;


  ReadOutputIdleTimer.Enabled :=True;
  if not Process2.Running then begin

    //WriteLn('Program: ', ParamStr(0));
    for i := 0 to ParamCount do
      parameters:= parameters + ' '+ Application.Params[i];

         Process2.CommandLine := 'moscrif-ide-app.exe -nosplash' +parameters;
         Process2.Execute;
  end;

end;

procedure TForm1.ReadOutputIdleTimerTimer(Sender: TObject);
var
  NoMoreOutput: boolean;
  outputJava : string;
  iResult : Integer;
  procedure DoStuffForProcess(Process: TProcess; form: TForm1);
  var
    Buffer,Line: string;
    BytesAvailable: DWord;
    BytesRead:LongInt;
    iMajor : Integer ;
  begin
    if Process.Running then
    begin
      BytesAvailable := Process.Output.NumBytesAvailable;
      BytesRead := 0;
      while BytesAvailable>0 do
      begin
        SetLength(Buffer, BytesAvailable);
        BytesRead := Process.OutPut.Read(Buffer[1], BytesAvailable);

        line:= copy(Buffer,1, BytesRead);
        iMajor := Pos('splash.hide-',line);
        if(iMajor > 0) then begin
                 //form.Close;
                 form.Hide;
        end;

        //OutputMemo.Text := OutputMemo.Text + copy(Buffer,1, BytesRead);
        BytesAvailable := Process.Output.NumBytesAvailable;
        //NoMoreOutput := false;
      end;
    //  if BytesRead>0 then
      //  OutputMemo.SelStart := Length(OutputMemo.Text);
    end else begin
         form.Close;
    end;
  end;
begin
 // outputJava:= 'WARNING: Java not found. Java is recomended.';
  repeat
    NoMoreOutput := true;
    //DoStuffForProcess(Process1, Process1StartButton, Process1OutputMemo);
    DoStuffForProcess(Process2, Form1);
  until noMoreOutput;

  {iResult := Pos('WARNING',outputJava);
  if(iResult<1  ) then begin
       //output.Append('Java ' + outputJava + '  OK');
  end;}

end;
{
procedure TForm1.Timer1Timer(Sender: TObject);
const
  CTimeout = 3000;
begin
  if (GetTickCount - FStartTicks > CTimeout) and OKToClose then
    Close;
end;}

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   //Action := caFree;
end;

initialization
  {$I moscrif-ide.lrs}

end.

