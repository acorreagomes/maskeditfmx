unit Providers.Dialogs.Factory;

interface

type
  TMascaras = class
  public
    class function CPF(Value: string): string;
    class function CNPJ(Value: string): string;
    class function Data(Value: string): string;
    class function Telefone(Value: string): string;
    class function Celular(Value: string): string;
    class function CEP(Value: string): string;
  end;


implementation

{ TMascaras }

uses Providers.Mascara.CPF, Providers.Mascara.CNPJ, Providers.Mascara.Data,
  Providers.Mascara.Celular, Providers.Mascara.Telefone, Providers.Mascara.CEP;

class function TMascaras.Celular(Value: string): string;
begin
  Result := TMascaraCelular.Create.ExecMask(value);
end;

class function TMascaras.CEP(Value: string): string;
begin
  Result := TMascaraCEP.Create.ExecMask(value);
end;

class function TMascaras.CNPJ(Value: string): string;
begin
  Result := TMascaraCNPJ.Create.ExecMask(value);
end;

class function TMascaras.CPF(Value: string): string;
begin
  Result := TMascaraCPF.Create.ExecMask(value);
end;

class function TMascaras.Data(Value: string): string;
begin
  Result := TMascaraData.Create.ExecMask(value);
end;

class function TMascaras.Telefone(Value: string): string;
begin
  Result := TMascaraTelefone.Create.ExecMask(value);
end;

end.
