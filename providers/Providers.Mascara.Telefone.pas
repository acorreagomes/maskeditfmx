unit Providers.Mascara.Telefone;

interface

uses
  Providers.Mascaras.Intf, System.MaskUtils, System.SysUtils;

type
  TMascaraTelefone = class(TInterfacedObject, IMascaras)
  private
    procedure RemoveParenteses(var Value: string);
  public
    function ExecMask(Value: string): string;
  end;

implementation

{ TMascaraTelefone }

function TMascaraTelefone.ExecMask(Value: string): string;
begin
  RemoveParenteses(Value);
  Result := FormatMaskText('\(00\)0000\-0000;0;', Value);
end;

procedure TMascaraTelefone.RemoveParenteses(var Value: string);
begin
  Delete(Value, AnsiPos('-', Value), 1);
  Delete(Value, AnsiPos('-', Value), 1);
  Delete(Value, AnsiPos('(', Value), 1);
  Delete(Value, AnsiPos(')', Value), 1);
end;

end.
