unit utilidades;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Forms, BGRABitmap, BGRABitmapTypes,
  LazUTF8, fpsexport, sqldb;

const
  SI = 'T';
  NO = 'F';

var
  GRADIENT1: TColor;
  GRADIENT2: TColor;

function ObtenerGUID: string;
function UTF8UppercaseFirstChar(s: string): string;
function ExportarDatasetXLS(aSQLDataset: TSQLQuery; aFileName: string;
  aFields: TStringArray): boolean; overload;

implementation

function ObtenerGUID: string;
var
  guid: TGuid;
begin
  Result := '';
  if CreateGUID(guid) = 0 then
  begin
    Result := guid.ToString(True);
  end;
end;

function UTF8UppercaseFirstChar(s: string): string;
var
  ch, rest: string;
begin
  ch := UTF8Copy(s, 1, 1);
  rest := Copy(s, Length(ch) + 1, MaxInt);
  Result := UTF8Uppercase(ch) + rest;
end;

function ExportarDatasetXLS(aSQLDataset: TSQLQuery; aFileName: string;
  aFields: TStringArray): boolean;
  overload;
var
  Exp: TFPSExport;
  ExpSettings: TFPSExportFormatSettings;
  s: string;
begin
  aSQLDataset.First; //assume we have a dataset called aSQLDataset
  Exp := TFPSExport.Create(nil);
  ExpSettings := TFPSExportFormatSettings.Create(True);
  try
    // por defecto xls
    ExpSettings.ExportFormat := efXLS; // choose file format
    if LowerCase(ExtractFileExt(aFileName)) = '.xlsx' then
      ExpSettings.ExportFormat := efXLSX;
    if LowerCase(ExtractFileExt(aFileName)) = '.ods' then
      ExpSettings.ExportFormat := efODS;
    ExpSettings.HeaderRow := True; // include header row with field names
    Exp.FormatSettings := ExpSettings; // apply settings to export object
    Exp.Dataset := aSQLDataset; // specify source
    Exp.FileName := aFileName;
    Exp.ExportFields.Clear;
    for s in aFields do
      Exp.ExportFields.AddField(s);
    Exp.Execute; // run the export
  finally
    Exp.Free;
    ExpSettings.Free;
  end;
end;

initialization
  GRADIENT1 := StrToBGRA('#CFDEF3');
  GRADIENT2 := StrToBGRA('#E0EAFC');
end.
