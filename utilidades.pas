unit utilidades;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Forms, BGRABitmap, BGRABitmapTypes;

const
  SI = 'T';
  NO = 'F';

var
  GRADIENT1: TColor;
  GRADIENT2: TColor;

function ObtenerGUID: string;

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

initialization
  GRADIENT1 := StrToBGRA('#CFDEF3');
  GRADIENT2 := StrToBGRA('#E0EAFC');
end.
