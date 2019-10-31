unit utilidades;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  SI = 'T';
  NO = 'F';

function ObtenerGUID: String;

implementation

function ObtenerGUID: String;
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

