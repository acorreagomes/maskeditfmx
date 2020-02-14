unit MaskEditFMX.Main;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, FMX.Edit, Providers.Mascaras.Types,
  Providers.Mascaras.Factory, System.UITypes;

type
  TMaskEditFMX = class(TEdit)
  private
    FMaskType: TMaskType;
    BackspaceDeleteKey: Boolean;
  const
    FilterCharDefault = '0123456789';
    procedure SetMaskType(const Value: TMaskType);
    procedure EditKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    function ExecutaMascara(Value: string): string;
    procedure SettingsMaskType;
  protected
    procedure EditTyping(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property MaskType: TMaskType read FMaskType write SetMaskType;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('CustomFMX', [TMaskEditFMX]);
end;

{ TMaskEditFMX }

procedure TMaskEditFMX.EditTyping(Sender: TObject);
begin
  if not(BackspaceDeleteKey) then
  begin
    TThread.Queue(nil,
      procedure
      var
        LStr: String;
      begin
        if not(Text.Trim.IsEmpty) then
          LStr :=  ExecutaMascara(Text);
        Text := LStr;
        CaretPosition := Text.Length;
      end);
  end;
end;

function TMaskEditFMX.ExecutaMascara(Value: string): string;
begin
  case MaskType of
    mtCPF : Result := TMascaras.CPF.ExecMask(Value);
    mtCNPJ: Result := TMascaras.CNPJ.ExecMask(Value);
    mtTelefone: Result := TMascaras.Telefone.ExecMask(Value);
    mtCelular: Result := TMascaras.Celular.ExecMask(Value);
    mtDate: Result := TMascaras.Data.ExecMask(Value);
    mtCEP: Result := TMascaras.CEP.ExecMask(Value);
    mtHora: Result := TMascaras.Hora.ExecMask(Value);
  else
    Result := Value;
  end;
end;

constructor TMaskEditFMX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  KeyboardType := TVirtualKeyboardType.PhonePad;
  TextSettings.HorzAlign := TTextAlign.Center;
  OnTyping := EditTyping;
  OnKeyDown := EditKeyDown;
end;

destructor TMaskEditFMX.Destroy;
begin
  inherited Destroy;
end;

procedure TMaskEditFMX.EditKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  BackspaceDeleteKey := Key in [8, 46];
end;

procedure TMaskEditFMX.SetMaskType(const Value: TMaskType);
begin
  FMaskType := Value;
  SettingsMaskType;
end;

procedure TMaskEditFMX.SettingsMaskType;
begin
  case FMaskType of
    mtCPF:
      begin
        FilterChar := FilterCharDefault + '.-';
        MaxLength := 14;
      end;
    mtCNPJ:
      begin
        FilterChar := FilterCharDefault + './-';
        MaxLength := 18;
      end;
    mtTelefone:
      begin
        FilterChar := FilterCharDefault + '()-';
        MaxLength := 13;
      end;
    mtCelular:
      begin
        FilterChar := FilterCharDefault + '()-';
        MaxLength := 14;
      end;
    mtDate:
      begin
        FilterChar := FilterCharDefault + '/';
        MaxLength := 10;
      end;
    mtCEP:
      begin
        FilterChar := FilterCharDefault + '-';
        MaxLength := 9;
      end;
    mtHora:
      begin
        FilterChar := FilterCharDefault + ':';
        MaxLength := 5;
      end;
  end;
end;

end.
