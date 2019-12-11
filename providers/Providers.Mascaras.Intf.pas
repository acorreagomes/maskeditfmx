unit Providers.Mascaras.Intf;

interface

uses
  System.UITypes;

type
  IMascaras = interface
    ['{0F1050E9-3029-4D22-AC14-D8B5AE187D80}']
    function ExecMask(Value: string): string;
  end;

implementation

end.
