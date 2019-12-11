unit Providers.Mascara.CPF;

interface

uses
  Providers.Mascaras.Intf, System.MaskUtils, System.SysUtils;

type
  TMascaraCPF = class(TInterfacedObject, IMascaras)
  private
    procedure RemovePontoTracoBarra(var Value: string);
  public
    function ExecMask(Value: string): string;
  end;

implementation

{ TMascaraCPF }

function TMascaraCPF.ExecMask(Value: string): string;
begin
  RemovePontoTracoBarra(Value);
  Result := FormatMaskText('000\.000\.000\-00;0;', Value);
end;

procedure TMascaraCPF.RemovePontoTracoBarra(var Value: string);
begin
  Delete(Value, AnsiPos('.', Value), 1);
  Delete(Value, AnsiPos('.', Value), 1);
  Delete(Value, AnsiPos('-', Value), 1);
  Delete(Value, AnsiPos('/', Value), 1);
  Delete(Value, AnsiPos('(', Value), 1);
  Delete(Value, AnsiPos(')', Value), 1);
end;

end.
