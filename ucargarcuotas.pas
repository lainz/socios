unit ucargarcuotas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin,
  ExtCtrls, sqldb, utilidades, Variants, Dateutils;

type

  { TfrmCargarCuotas }

  TfrmCargarCuotas = class(TForm)
    btnCancelar: TButton;
    btnGuardar: TButton;
    cbMes: TComboBox;
    lblMes: TLabel;
    lblAnio: TLabel;
    pnlMenu: TPanel;
    seAnio: TSpinEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure pnlMenuPaint(Sender: TObject);
  private

  public
    procedure GuardarCuota(SQLQuery: TSQLQuery; idSocio: string);
  end;

var
  frmCargarCuotas: TfrmCargarCuotas;

implementation

{$R *.lfm}

{ TfrmCargarCuotas }

procedure TfrmCargarCuotas.btnGuardarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmCargarCuotas.FormCreate(Sender: TObject);
begin
  seAnio.Value := CurrentYear;
  cbMes.ItemIndex := MonthOf(now) - 1;
end;

procedure TfrmCargarCuotas.FormPaint(Sender: TObject);
var
  pnl: TForm;
begin
  pnl := TForm(Sender);
  pnl.Canvas.GradientFill(Rect(0, 0, pnl.Width, pnl.Height), GRADIENT2,
    GRADIENT1, gdVertical);
end;

procedure TfrmCargarCuotas.pnlMenuPaint(Sender: TObject);
var
  pnl: TPanel;
begin
  pnl := TPanel(Sender);
  pnl.Canvas.GradientFill(Rect(0, 0, pnl.Width, pnl.Height), GRADIENT1,
    GRADIENT2, gdVertical);
  pnl.Canvas.Pen.Color := clWhite;
  pnl.Canvas.Line(0, 0, pnl.Width, 0);
end;

procedure TfrmCargarCuotas.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmCargarCuotas.GuardarCuota(SQLQuery: TSQLQuery; idSocio: string);
begin
  if SQLQuery.Locate('idsocio;mes;anio',
    VarArrayOf([idSocio, cbMes.ItemIndex + 1, seAnio.Value]), []) then
    SQLQuery.Edit
  else
    SQLQuery.Append;
  SQLQuery.FieldByName('id').AsString := ObtenerGUID;
  SQLQuery.FieldByName('idsocio').AsString := idSocio;
  SQLQuery.FieldByName('mes').AsInteger := cbMes.ItemIndex + 1;
  SQLQuery.FieldByName('anio').AsInteger := seAnio.Value;
  SQLQuery.FieldByName('pagado').AsString := SI;
  SQLQuery.Post;
end;

end.
