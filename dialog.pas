unit Dialog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,process
   {$IFDEF MSWINDOWS}
         ,windows
 {$ENDIF} ;

type

  { TErrorDialog }

  TErrorDialog = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Download: TButton;
    mmError: TMemo;
    procedure Button2Click(Sender: TObject);
    procedure DownloadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FErrorMessage: string;
    FLinkMessage: PChar;
    FLinkMessage2: PChar;
    { private declarations }
  public
        property ErrorMessage: string read FErrorMessage write FErrorMessage;
        property LinkMessage: PChar read FLinkMessage write FLinkMessage;
        property LinkMessage2: PChar read FLinkMessage2 write FLinkMessage2;
    { public declarations }
  end; 

var
  ErrorDialog: TErrorDialog;

implementation

{$R *.lfm}

{ TErrorDialog }

procedure TErrorDialog.DownloadClick(Sender: TObject);
{var
  Browser, Params: string;}
begin
   {  FindDefaultBrowser(Browser, Params);
     with TProcess.Create(nil) do
     try
       Executable := Browser;
       Params:=Format(Params, [FLinkMessage]);
       Params:=copy(Params,2,length(Params)-2); // remove "", the new version of TProcess.Parameters does that itself
       Parameters.Add(Params);
       Options := [poNoConsole];
       Execute;
     finally
       Free;
     end;}

    ShellExecute(Handle,
               'open',
               FLinkMessage,
               nil,
               nil,
               SW_SHOW);
end;

procedure TErrorDialog.Button2Click(Sender: TObject);
begin
     ShellExecute(Handle,
                   'open',
                   FLinkMessage2,
                   nil,
                   nil,
                   SW_SHOW);
end;

procedure TErrorDialog.FormCreate(Sender: TObject);
begin
     mmError.Text:=FErrorMessage;
     if(FLinkMessage2 <> '') then begin
         Button2.Caption:='Download .Net';
         Download.Caption:='Download Mono';
         Button2.Visible:=True;
     end;
end;

procedure TErrorDialog.FormShow(Sender: TObject);
begin
     mmError.Text:=FErrorMessage;
     if(FLinkMessage2 <> '') then begin
         Button2.Caption:='Download .Net';
         Download.Caption:='Download Mono';
         Button2.Visible:=True;
     end;
end;

end.

