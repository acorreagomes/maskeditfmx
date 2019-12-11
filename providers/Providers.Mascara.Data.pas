unit Providers.Mascara.Data;

interface

uses
  Providers.Mascaras.Intf, System.MaskUtils, System.SysUtils;

type
  TMascaraData = class(TInterfacedObject, IMascaras)
  private
    procedure RemoveBarras(var Value: string);
  public
    function ExecMask(Value: string): string;
  end;

implementation

{ TMascaraData }

function TMascaraData.ExecMask(Value: string): string;
begin
  RemoveBarras(Value);
  Result := FormatMaskText('00\/00\/0000;0;', Value);
end;

procedure TMascaraData.RemoveBarras(var Value: string);
begin
  Delete(Value, AnsiPos('/', Value), 1);
  Delete(Value, AnsiPos('/', Value), 1);
end;

end.
