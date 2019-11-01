unit utilidades;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  SI = 'T';
  NO = 'F';
  GRADIENT1 = $00EEEFB1;
  GRADIENT2 = $00CFFAFC;

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

end.
