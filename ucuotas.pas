unit ucuotas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, sqldb, Forms, Controls, Graphics, Dialogs, DBGrids,
  ExtCtrls, StdCtrls, ucargarcuotas, utilidades, dmsqlite;

type

  { TfrmCuotas }

  TfrmCuotas = class(TForm)
    btnCargar: TButton;
    btnCambiarEstadoEliminado: TButton;
    DataSource1: TDataSource;
    dbgCuotas: TDBGrid;
    pnlMenu: TPanel;
    SQLQuery1: TSQLQuery;
    procedure btnCargarClick(Sender: TObject);
    procedure btnCambiarEstadoEliminadoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Mostrar;
  public
    idSocio: string;
  end;

var
  frmCuotas: TfrmCuotas;

implementation

{$R *.lfm}

{ TfrmCuotas }

procedure TfrmCuotas.FormCreate(Sender: TObject);
begin
  SQLQuery1.DataBase := dmsqlite.DataModule1.SQLite3Connection1;
  SQLQuery1.Transaction := dmsqlite.DataModule1.SQLTransaction1;
end;

procedure TfrmCuotas.btnCargarClick(Sender: TObject);
begin
  if Assigned(frmCargarCuotas) then
    frmCargarCuotas.Free;
  Application.CreateForm(TfrmCargarCuotas, frmCargarCuotas);
  case frmCargarCuotas.ShowModal of
    mrOk:
    begin
      frmCargarCuotas.GuardarCuota(SQLQuery1, idSocio);
      Mostrar;
    end;
  end;
  FreeAndNil(frmCargarCuotas);
end;

procedure TfrmCuotas.btnCambiarEstadoEliminadoClick(Sender: TObject);
begin
  SQLQuery1.Edit;
  if SQLQuery1.FieldByName('pagado').AsString = SI then
    SQLQuery1.FieldByName('pagado').AsString := NO
  else
    SQLQuery1.FieldByName('pagado').AsString := SI;
  SQLQuery1.Post;
end;

procedure TfrmCuotas.FormShow(Sender: TObject);
begin
  Mostrar;
end;

procedure TfrmCuotas.Mostrar;
begin
  SQLQuery1.Active := False;
  SQLQuery1.SQL.Text := 'SELECT * FROM cuotas WHERE idsocio = ' +
    QuotedStr(idSocio) + ' ORDER BY anio DESC, mes DESC';
  SQLQuery1.Active := True;
  btnCambiarEstadoEliminado.Enabled := SQLQuery1.RecordCount > 0;
end;

end.
