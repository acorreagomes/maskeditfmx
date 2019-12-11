unit MaskEditFMX.Main;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, FMX.Edit, Providers.Mascaras.Types, Providers.Dialogs.Factory;

type
  TMaskEditFMX = class(TEdit)
  private
    FMaskType: TMaskType;
    BackspaceDeleteKey: Boolean;
    procedure SetMaskType(const Value: TMaskType);
    procedure EditKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    function ExecutaMascara(Value: string): string;
  protected
    procedure Typing(Sender: TObject);
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

procedure TMaskEditFMX.Typing(Sender: TObject);
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
    mtCPF : Result := TMascaras.CPF(Value);
    mtCNPJ: Result := TMascaras.CNPJ(Value);
    mtDate: Result := TMascaras.Data(Value);
    mtTelefone: Result := TMascaras.Telefone(Value);
    mtCelular: Result := TMascaras.Celular(Value);
  else
    Result := Value;
  end;
end;

constructor TMaskEditFMX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  KeyboardType := TVirtualKeyboardType.PhonePad;
  TextSettings.HorzAlign := TTextAlign.Center;
  FilterChar := '0123456789./-()';
  OnTyping := Typing;
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
  case FMaskType of
    mtCPF:
      begin
        TextPrompt := '___.___.___-__';
        MaxLength := 14;
      end;
    mtCNPJ:
      begin
        TextPrompt := '__.___.___/____-__';
        MaxLength := 18;
      end;
    mtTelefone:
      begin
        TextPrompt := '(__)-____-____';
        MaxLength := 13;
      end;
    mtCelular:
      begin
        TextPrompt := '(__)-_____-____';
        MaxLength := 14;
      end;
    mtDate:
      begin
        TextPrompt := '__/__/____';
        MaxLength := 10;
      end;
  end;
end;

end.
