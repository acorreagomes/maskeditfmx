unit Providers.Mascara.CEP;

interface

uses
  Providers.Mascaras.Intf, System.MaskUtils, System.SysUtils;

type
  TMascaraCEP = class(TInterfacedObject, IMascaras)
  private
    procedure RemovePontoTracoBarra(var Value: string);
  public
    function ExecMask(Value: string): string;
  end;

implementation

{ TMascaraCEP }

function TMascaraCEP.ExecMask(Value: string): string;
begin
  RemovePontoTracoBarra(Value);
  Result := FormatMaskText('00000\-000;0;', Value);
end;

procedure TMascaraCEP.RemovePontoTracoBarra(var Value: string);
begin
  Delete(Value, AnsiPos('-', Value), 1);
end;

end.
