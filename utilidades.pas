unit utilidades;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Forms, BGRABitmap, BGRABitmapTypes, LazUTF8;

const
  SI = 'T';
  NO = 'F';

var
  GRADIENT1: TColor;
  GRADIENT2: TColor;

function ObtenerGUID: string;
function UTF8UppercaseFirstChar(s: String): String;

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

function UTF8UppercaseFirstChar(s: String): String;
var
  ch, rest: String;
begin
  ch := UTF8Copy(s, 1, 1);
  rest := Copy(s, Length(ch)+1, MaxInt);
  Result := UTF8Uppercase(ch) + rest
end;



initialization
  GRADIENT1 := StrToBGRA('#CFDEF3');
  GRADIENT2 := StrToBGRA('#E0EAFC');
end.
