unit MaskEditFMX.Main;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, FMX.Edit, Providers.Mascaras.Types,
  Providers.Mascaras.Factory, System.UITypes;

type
  TMaskEditFMX = class(TCustomEdit)
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
    property ControlType;
    property OnPresentationNameChoosing;
    { inherited }
    property Cursor default crIBeam;
    property CanFocus default True;
    property CanParentFocus;
    property DisableFocusEffect;
    property ReturnKeyType;
    property ReadOnly;
    property Text;
    property TextSettings;
    property ImeMode;
    property Position;
    property Width;
    property Height;
    property ClipChildren default False;
    property ClipParent default False;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Hint;
    property HitTest default True;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property TextPrompt;
    property StyleLookup;
    property StyledSettings;
    property TouchTargetExpansion;
    property Visible default True;
    property Caret;
    property KillFocusByReturn;
    property CheckSpelling;
    property ParentShowHint;
    property ShowHint;
    property CharCase default TCustomEditModel.DefaultCharCase;
    { events }
    property OnChange;
    property OnChangeTracking;
    property OnApplyStyleLookup;
    property OnValidating;
    property OnValidate;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnKeyDown;
    property OnKeyUp;
    property OnCanFocus;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
    property OnResized;

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
    mtCPF : Result := TMascaras.CPF(Value);
    mtCNPJ: Result := TMascaras.CNPJ(Value);
    mtTelefone: Result := TMascaras.Telefone(Value);
    mtCelular: Result := TMascaras.Celular(Value);
    mtDate: Result := TMascaras.Data(Value);
    mtCEP: Result := TMascaras.CEP(Value);
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
  end;
end;

end.
