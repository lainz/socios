unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, DB, Forms, Controls, Graphics, Dialogs,
  DBGrids, ExtCtrls, StdCtrls, Menus, dmsqlite, unuevosocio, Grids;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    cbOrdenar: TComboBox;
    chkMostrarSociosEliminados: TCheckBox;
    DataSource1: TDataSource;
    dbgSocios: TDBGrid;
    edtBuscar: TEdit;
    lblOrdenar: TLabel;
    lblBuscar: TLabel;
    MainMenu1: TMainMenu;
    miEditarSocio: TMenuItem;
    miNuevoSocio: TMenuItem;
    miArchivo: TMenuItem;
    N1: TMenuItem;
    miSalir: TMenuItem;
    pnlMenu: TPanel;
    SQLQuery1: TSQLQuery;
    procedure cbOrdenarChange(Sender: TObject);
    procedure chkMostrarSociosEliminadosChange(Sender: TObject);
    procedure dbgSociosDblClick(Sender: TObject);
    procedure dbgSociosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgSociosTitleClick(Column: TColumn);
    procedure edtBuscarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miEditarSocioClick(Sender: TObject);
    procedure miNuevoSocioClick(Sender: TObject);
    procedure miSalirClick(Sender: TObject);
  private
    ordenarTabla: string;
  public

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  SQLQuery1.DataBase := dmsqlite.DataModule1.SQLite3Connection1;
  SQLQuery1.Transaction := dmsqlite.DataModule1.SQLTransaction1;
  cbOrdenar.ItemIndex := 1;
  cbOrdenarChange(nil);
end;

procedure TfrmMain.miEditarSocioClick(Sender: TObject);
begin
  if Assigned(frmNuevoSocio) then
    frmNuevoSocio.Free;
  Application.CreateForm(TfrmNuevoSocio, frmNuevoSocio);
  frmNuevoSocio.Caption := 'Editar Socio';
  frmNuevoSocio.LlenarCamposDesdeDB(SQLQuery1);
  case frmNuevoSocio.ShowModal of
    mrOk: frmNuevoSocio.GuardarEdicionSocio(SQLQuery1);
  end;
  FreeAndNil(frmNuevoSocio);
end;

procedure TfrmMain.miNuevoSocioClick(Sender: TObject);
begin
  if Assigned(frmNuevoSocio) then
    frmNuevoSocio.Free;
  Application.CreateForm(TfrmNuevoSocio, frmNuevoSocio);
  frmNuevoSocio.Caption := 'Nuevo Socio';
  case frmNuevoSocio.ShowModal of
    mrOk: frmNuevoSocio.GuardarNuevoSocio(SQLQuery1);
  end;
  FreeAndNil(frmNuevoSocio);
end;

procedure TfrmMain.miSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.edtBuscarChange(Sender: TObject);
var
  txt, filter: string;
  w: string;
  words: TStringArray;
begin
  filter := '';
  txt := edtBuscar.Text;
  words := txt.Split([' ']);
  SQLQuery1.Filtered := False;
  SQLQuery1.Filter := '';
  for w in words do
  begin
    txt := QuotedStr('*' + w + '*');
    if filter <> '' then
      filter := filter + ' and ';
    filter := filter + '((numero=' + txt + ') or (nombre=' + txt +
      ') or (nacimiento=' + txt + ') or (nacionalidad=' + txt +
      ') or (ingreso=' + txt + ') or (documento=' + txt + ') or (domicilio=' +
      txt + ') or (telefono=' + txt + ') or (jubilacion=' + txt + '))';
  end;
  SQLQuery1.FilterOptions := [foCaseInsensitive];
  SQLQuery1.Filter := filter;
  SQLQuery1.Filtered := edtBuscar.Text <> '';
end;

procedure TfrmMain.cbOrdenarChange(Sender: TObject);
begin
  case cbOrdenar.ItemIndex of
    0: ordenarTabla := 'numero';
    1: ordenarTabla := 'nombre';
    2: ordenarTabla := 'nacimiento';
    3: ordenarTabla := 'nacionalidad';
    4: ordenarTabla := 'ingreso';
    5: ordenarTabla := 'documento';
    6: ordenarTabla := 'domicilio';
    7: ordenarTabla := 'telefono';
    8: ordenarTabla := 'jubilacion';
  end;
  SQLQuery1.Active := False;
  if (chkMostrarSociosEliminados.Checked) then
    SQLQuery1.SQL.Text := 'SELECT * FROM socios ORDER BY ' + ordenarTabla
  else
    SQLQuery1.SQL.Text := 'SELECT * FROM socios WHERE eliminado = ''F'' ORDER BY ' + ordenarTabla;
  SQLQuery1.Active := True;
end;

procedure TfrmMain.chkMostrarSociosEliminadosChange(Sender: TObject);
begin
  cbOrdenarChange(nil);
end;

procedure TfrmMain.dbgSociosDblClick(Sender: TObject);
begin
  miEditarSocioClick(nil);
end;

procedure TfrmMain.dbgSociosDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

end;

procedure TfrmMain.dbgSociosTitleClick(Column: TColumn);
begin
  cbOrdenar.ItemIndex := Column.Index - 1;
  cbOrdenarChange(nil);
end;

end.
