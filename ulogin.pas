unit ulogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  utilidades, LCLType;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    btnEntrar: TButton;
    edPassword: TEdit;
    imgLogo: TImage;
    lblPassword: TLabel;
    procedure btnEntrarClick(Sender: TObject);
    procedure edPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
  private

  public

  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.lfm}

{ TfrmLogin }

procedure TfrmLogin.FormPaint(Sender: TObject);
var
  pnl: TForm;
begin
  pnl := TForm(Sender);
  pnl.Canvas.GradientFill(Rect(0, 0, pnl.Width, pnl.Height), GRADIENT1,
    GRADIENT2, gdVertical);
end;

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
  if (edPassword.Text = PASSWORD) then
  begin
    ModalResult := mrOk;
  end
  else
  begin
    ShowMessage('Contraseña incorrecta.');
  end;
end;

procedure TfrmLogin.edPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnEntrarClick(nil);
end;

end.

