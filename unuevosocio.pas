unit unuevosocio;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  utilidades, sqldb;

type

  { TfrmNuevoSocio }

  TfrmNuevoSocio = class(TForm)
    btnGuardar: TButton;
    btnCancelar: TButton;
    chkJubilado: TCheckBox;
    chkPensionado: TCheckBox;
    chkVitalicio: TCheckBox;
    chkEliminado: TCheckBox;
    edtNumero: TEdit;
    edtNombre: TEdit;
    edtNacimiento: TEdit;
    edtNacionalidad: TEdit;
    edtIngreso: TEdit;
    edtDocumento: TEdit;
    edtDomicilio: TEdit;
    edtTelefono: TEdit;
    edtJubilacion: TEdit;
    lblNumero: TLabel;
    lblNombre: TLabel;
    lblNacimiento: TLabel;
    lblNacionalidad: TLabel;
    lblIngreso: TLabel;
    lblDocumento: TLabel;
    lblDomicilio: TLabel;
    lblTelefono: TLabel;
    lblJubilacion: TLabel;
    pnlMenu: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure pnlMenuPaint(Sender: TObject);
    procedure Capitalizar(Sender: TObject);
    procedure LimpiarNumero(Sender: TObject);
    procedure AcomodarFecha(Sender: TObject);
  private
    procedure LlenarCamposDB(const socios: TSQLQuery);
  public
    procedure LlenarCamposDesdeDB(const socios: TSQLQuery);
    procedure GuardarNuevoSocio(const socios: TSQLQuery);
    procedure GuardarEdicionSocio(const socios: TSQLQuery);
  end;

var
  frmNuevoSocio: TfrmNuevoSocio;

implementation

{$R *.lfm}

{ TfrmNuevoSocio }

procedure TfrmNuevoSocio.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmNuevoSocio.btnGuardarClick(Sender: TObject);
begin
  if (edtNumero.Text = '') then
  begin
    ShowMessage('Ingrese el número de socio.');
    exit;
  end;
  if (edtNombre.Text = '') then
  begin
    ShowMessage('Ingrese el nombre del socio.');
    exit;
  end;
  ModalResult := mrOk;
end;

procedure TfrmNuevoSocio.FormPaint(Sender: TObject);
var
  pnl: TForm;
begin
  pnl := TForm(Sender);
  pnl.Canvas.GradientFill(Rect(0, 0, pnl.Width, pnl.Height), GRADIENT2,
    GRADIENT1, gdVertical);
end;

procedure TfrmNuevoSocio.pnlMenuPaint(Sender: TObject);
var
  pnl: TPanel;
begin
  pnl := TPanel(Sender);
  pnl.Canvas.GradientFill(Rect(0, 0, pnl.Width, pnl.Height), GRADIENT1,
    GRADIENT2, gdVertical);
  pnl.Canvas.Pen.Color := clWhite;
  pnl.Canvas.Line(0, 0, pnl.Width, 0);
end;

procedure TfrmNuevoSocio.Capitalizar(Sender: TObject);
var
  w: string;
  txt, tmp: string;
  nombres: TStringArray;
begin
  tmp := TEdit(Sender).Text;
  if (not tmp.IsEmpty) then
  begin
    nombres := tmp.Split(' ');
    txt := '';
    for w in nombres do
    begin
      txt := txt + UTF8UppercaseFirstChar(w.ToLower) + ' ';
    end;
    TEdit(Sender).Text := txt.Trim;
  end;
end;

procedure TfrmNuevoSocio.LimpiarNumero(Sender: TObject);
var
  txt: string;
begin
  txt := TEdit(Sender).Text;
  TEdit(Sender).Text := txt.Trim.Replace('.', '', [rfReplaceAll]).Replace(' ',
    '', [rfReplaceAll]);
end;

procedure TfrmNuevoSocio.AcomodarFecha(Sender: TObject);
var
  txt: string;
begin
  txt := TEdit(Sender).Text;
  TEdit(Sender).Text := txt.Trim.Replace(' ', '', [rfReplaceAll]);
end;

procedure TfrmNuevoSocio.LlenarCamposDB(const socios: TSQLQuery);
begin
  socios.FieldByName('numero').AsString := edtNumero.Text;
  socios.FieldByName('nombre').AsString := edtNombre.Text;
  socios.FieldByName('nacimiento').AsString := edtNacimiento.Text;
  socios.FieldByName('nacionalidad').AsString := edtNacionalidad.Text;
  socios.FieldByName('ingreso').AsString := edtIngreso.Text;
  socios.FieldByName('documento').AsString := edtDocumento.Text;
  socios.FieldByName('domicilio').AsString := edtDomicilio.Text;
  socios.FieldByName('telefono').AsString := edtTelefono.Text;
  socios.FieldByName('jubilacion').AsString := edtJubilacion.Text;
  if chkVitalicio.Checked then
    socios.FieldByName('vitalicio').AsString := SI
  else
    socios.FieldByName('vitalicio').AsString := NO;
  if chkJubilado.Checked then
    socios.FieldByName('jubilado').AsString := SI
  else
    socios.FieldByName('jubilado').AsString := NO;
  if chkPensionado.Checked then
    socios.FieldByName('pensionado').AsString := SI
  else
    socios.FieldByName('pensionado').AsString := NO;
  if chkEliminado.Checked then
    socios.FieldByName('activo').AsString := SI
  else
    socios.FieldByName('activo').AsString := NO;
end;

procedure TfrmNuevoSocio.LlenarCamposDesdeDB(const socios: TSQLQuery);
begin
  edtNumero.Text := socios.FieldByName('numero').AsString;
  edtNombre.Text := socios.FieldByName('nombre').AsString;
  edtNacimiento.Text := socios.FieldByName('nacimiento').AsString;
  edtNacionalidad.Text := socios.FieldByName('nacionalidad').AsString;
  edtIngreso.Text := socios.FieldByName('ingreso').AsString;
  edtDocumento.Text := socios.FieldByName('documento').AsString;
  edtDomicilio.Text := socios.FieldByName('domicilio').AsString;
  edtTelefono.Text := socios.FieldByName('telefono').AsString;
  edtJubilacion.Text := socios.FieldByName('jubilacion').AsString;
  chkVitalicio.Checked := socios.FieldByName('vitalicio').AsString = SI;
  chkJubilado.Checked := socios.FieldByName('jubilado').AsString = SI;
  chkPensionado.Checked := socios.FieldByName('pensionado').AsString = SI;
  chkEliminado.Checked := socios.FieldByName('activo').AsString = SI;
end;

procedure TfrmNuevoSocio.GuardarNuevoSocio(const socios: TSQLQuery);
begin
  socios.Append;
  socios.FieldByName('id').AsString := ObtenerGUID;
  LlenarCamposDB(socios);
  socios.Post;
end;

procedure TfrmNuevoSocio.GuardarEdicionSocio(const socios: TSQLQuery);
begin
  socios.Edit;
  LlenarCamposDB(socios);
  socios.Post;
end;

end.
