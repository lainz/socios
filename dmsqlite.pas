unit dmsqlite;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, sqlite3conn, sqldb;

const
  DBVERSION = 1;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    SQLite3Connection1: TSQLite3Connection;
    SQLTransaction1: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  // Archivo DB
  SQLite3Connection1.DatabaseName := Application.Location + 'socios.sqlite';
  SQLite3Connection1.Connected := True;

  // Tabla Socios v1
  SQLite3Connection1.ExecuteDirect(
    'CREATE TABLE IF NOT EXISTS socios(id varchar(36) NOT NULL PRIMARY KEY, numero varchar(50), nombre varchar(50), nacimiento varchar(50), nacionalidad varchar(50), ingreso varchar(50), documento varchar(50), domicilio varchar(50), telefono varchar(50), jubilacion varchar(50), eliminado varchar(1));');

  // Tabla Cuotas v1
  SQLite3Connection1.ExecuteDirect(
    'CREATE TABLE IF NOT EXISTS cuotas(id varchar(36) NOT NULL PRIMARY KEY, idsocio varchar(36) NOT NULL, mes int, anio int, eliminado varchar(1))');

  // Tabla db v1
  SQLite3Connection1.ExecuteDirect(
    'CREATE TABLE IF NOT EXISTS db(id int NOT NULL PRIMARY KEY, version int NOT NULL)');
  SQLite3Connection1.ExecuteDirect('REPLACE INTO db (id, version) VALUES (0, ' +
    DBVERSION.ToString + ')');

  SQLTransaction1.Commit;
end;

end.
