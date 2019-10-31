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
  ModalResult := mrOk;
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
  if chkEliminado.Checked then
    socios.FieldByName('eliminado').AsString := SI
  else
    socios.FieldByName('eliminado').AsString := NO;
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
  chkEliminado.Checked := socios.FieldByName('eliminado').AsString = SI;
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

