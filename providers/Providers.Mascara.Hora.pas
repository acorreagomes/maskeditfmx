unit Providers.Mascara.Hora;

interface

uses
  Providers.Mascaras.Intf, System.MaskUtils, System.SysUtils;

type
  TMascaraHora = class(TInterfacedObject, IMascaras)
  private
    procedure RemoveDoisPontos(var Value: string);
  public
    function ExecMask(Value: string): string;
  end;

implementation

{ TMascaraHora }

function TMascaraHora.ExecMask(Value: string): string;
begin
  RemoveDoisPontos(Value);
  Result := FormatMaskText('00\:00;0;', Value);
end;

procedure TMascaraHora.RemoveDoisPontos(var Value: string);
begin
  Delete(Value, AnsiPos(':', Value), 1);
end;

end.
