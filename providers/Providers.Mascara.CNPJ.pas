unit Providers.Mascara.CNPJ;

interface

uses
  Providers.Mascaras.Intf, System.MaskUtils, System.SysUtils;

type
  TMascaraCNPJ = class(TInterfacedObject, IMascaras)
  private
    procedure RemovePontoTracoBarra(var Value: string);
  public
    function ExecMask(Value: string): string;
  end;

implementation

{ TMascaraCNPJ }

function TMascaraCNPJ.ExecMask(Value: string): string;
begin
  RemovePontoTracoBarra(Value);
  Result := FormatMaskText('00\.000\.000\/0000\-00;0;', Value);
end;

procedure TMascaraCNPJ.RemovePontoTracoBarra(var Value: string);
begin
  Delete(Value, AnsiPos('.', Value), 1);
  Delete(Value, AnsiPos('.', Value), 1);
  Delete(Value, AnsiPos('-', Value), 1);
  Delete(Value, AnsiPos('/', Value), 1);
  Delete(Value, AnsiPos('(', Value), 1);
  Delete(Value, AnsiPos(')', Value), 1);
end;

end.
