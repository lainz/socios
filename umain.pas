unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, DB, Forms, Controls, Graphics, Dialogs,
  DBGrids, ExtCtrls, StdCtrls, dmsqlite;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    DataSource1: TDataSource;
    dbgSocios: TDBGrid;
    edtBuscar: TEdit;
    lblBuscar: TLabel;
    Panel1: TPanel;
    SQLQuery1: TSQLQuery;
    procedure edtBuscarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

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
  SQLQuery1.Active := True;
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
      ') or (nacimiento=' + txt + ') or (nacionalidad=' + txt + ') or (ingreso=' +
      txt + ') or (documento=' + txt + ') or (domicilio=' + txt + ') or (telefono=' +
      txt + ') or (jubilacion=' + txt + '))';
  end;
  SQLQuery1.FilterOptions := [foCaseInsensitive];
  SQLQuery1.Filter := filter;
  SQLQuery1.Filtered := edtBuscar.Text <> '';
end;

end.
