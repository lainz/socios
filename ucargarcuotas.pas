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
  private

  public
    procedure GuardarCuota(SQLQuery: TSQLQuery; idSocio: String);
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

procedure TfrmCargarCuotas.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmCargarCuotas.GuardarCuota(SQLQuery: TSQLQuery; idSocio: String);
begin
  if SQLQuery.Locate('idsocio;mes;anio', VarArrayOf([idSocio,StrToInt(cbMes.Text), seAnio.Value]), []) then
    SQLQuery.Edit
  else
    SQLQuery.Append;
  SQLQuery.FieldByName('id').AsString := ObtenerGUID;
  SQLQuery.FieldByName('idsocio').AsString := idSocio;
  SQLQuery.FieldByName('mes').AsInteger := StrToInt(cbMes.Text);
  SQLQuery.FieldByName('anio').AsInteger := seAnio.Value;
  SQLQuery.FieldByName('eliminado').AsString := NO;
  SQLQuery.Post;
end;

end.

