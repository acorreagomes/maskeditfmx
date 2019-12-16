unit Providers.Mascaras.Factory;

interface

uses
  Providers.Mascaras.Intf;

type
  TMascaras = class
  public
    class function CPF: IMascaras;
    class function CNPJ: IMascaras;
    class function Data: IMascaras;
    class function Telefone: IMascaras;
    class function Celular: IMascaras;
    class function CEP: IMascaras;
  end;


implementation

{ TMascaras }

uses Providers.Mascara.CPF, Providers.Mascara.CNPJ, Providers.Mascara.Data,
  Providers.Mascara.Celular, Providers.Mascara.Telefone, Providers.Mascara.CEP;

class function TMascaras.Celular: IMascaras;
begin
  Result := TMascaraCelular.Create;
end;

class function TMascaras.CEP: IMascaras;
begin
  Result := TMascaraCEP.Create;
end;

class function TMascaras.CNPJ: IMascaras;
begin
  Result := TMascaraCNPJ.Create;
end;

class function TMascaras.CPF: IMascaras;
begin
  Result := TMascaraCPF.Create;
end;

class function TMascaras.Data: IMascaras;
begin
  Result := TMascaraData.Create;
end;

class function TMascaras.Telefone: IMascaras;
begin
  Result := TMascaraTelefone.Create;
end;

end.
