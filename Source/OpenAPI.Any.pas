unit OpenAPI.Any;

interface

uses
  System.Rtti;

{$SCOPEDENUMS ON}

type

{$REGION ENUMTYPES}
  /// <summary>
  /// Type of an <see cref="IOpenApiAny"/>
  /// </summary>
  TAny = (
    TypePrimitive,
    TypeNull,
    TypeArray,
    TypeObject
  );

  /// <summary>
  /// Primitive type.
  /// </summary>
  TPrimitive = (
    TypeInteger,
    TypeLong,
    TypeFloat,
    TypeDouble,
    TypeString,
    TypeBytes,
    TypeBinary,
    TypeBoolean,
    TypeDate,
    TypeDateTime,
    TypePassword
  );

{$ENDREGION}


  /// <summary>
  /// Represents an Open API element.
  /// </summary>
  IOpenApiElement = interface
  ['{F7230DE3-B52E-4A2A-8A32-FF409E4ADD49}']
  end;

  /// <summary>
  /// Base interface for all the types that represent Open API Any.
  /// </summary>
  IOpenApiAny = interface(IOpenApiElement)
  ['{AB82F994-F48C-4D24-89A7-7EDC2854ED62}']
    /// <summary>
    /// Type of an <see cref="IOpenApiAny"/>.
    /// </summary>
   function GetAny: TAny;
   property Any: TAny read GetAny;
  end;

  /// <summary>
  /// Base interface for the Primitive type.
  /// </summary>
  IOpenApiPrimitive = interface(IOpenApiAny)
  ['{193D437C-682E-457D-B24F-C1C15EDFAD67}']
    /// <summary>
    /// Primitive type.
    /// </summary>
    function GetPrimitive: TPrimitive;
    property Primitive: TPrimitive read GetPrimitive;
  end;

  /// <summary>
  /// Open API primitive class.
  /// </summary>
  /// <typeparam name="T"></typeparam>
  TOpenAPIAnyValue<T> = class(TInterfacedObject, IOpenApiPrimitive)
  private
    FValue: T;
    function GetAny: TAny;
  protected
    function GetPrimitive: TPrimitive; virtual; abstract;
  public
    /// <summary>
    /// Initializes the <see cref="IOpenApiPrimitive"/> class with the given value.
    /// </summary>
    /// <param name="value"></param>
    constructor Create(const AValue: T);

    /// <summary>
    /// The kind of <see cref="IOpenApiAny"/>.
    /// </summary>
    property Any: TAny read GetAny;

    /// <summary>
    /// The primitive class this object represents.
    /// </summary>
    property PrimitiveType: TPrimitive read GetPrimitive;

    /// <summary>
    /// Value of this <see cref="IOpenApiPrimitive"/>
    /// </summary>
    property Value: T read FValue;
  end;

  /// <summary>
  /// Open API boolean.
  /// </summary>
  TOpenAPIInteger = class(TOpenAPIAnyValue<Integer>)
  protected
    /// <summary>
    /// Primitive type this object represents.
    /// </summary>
    function GetPrimitive: TPrimitive; override;
  public
    /// <summary>
    /// Initializes the <see cref="TOpenApiInteger"/> class.
    /// </summary>
    /// <param name="value"></param>
    constructor Create(const AValue: Integer);
  end;

  /// <summary>
  /// Open API boolean.
  /// </summary>
  TOpenAPIBoolean = class(TOpenAPIAnyValue<Boolean>)
  protected
    /// <summary>
    /// Primitive type this object represents.
    /// </summary>
    function GetPrimitive: TPrimitive; override;
  public
    /// <summary>
    /// Initializes the <see cref="OpenApiBoolean"/> class.
    /// </summary>
    /// <param name="value"></param>
    constructor Create(const AValue: Boolean);
  end;

  /// <summary>
  /// Open API boolean.
  /// </summary>
  TOpenAPIString = class(TOpenAPIAnyValue<string>)
  protected
    /// <summary>
    /// Primitive type this object represents.
    /// </summary>
    function GetPrimitive: TPrimitive; override;
  public
    /// <summary>
    /// Initializes the <see cref="TOpenApiString"/> class.
    /// </summary>
    /// <param name="value"></param>
    constructor Create(const AValue: string);
  end;

  TOpenAPIAny = class
  private
    FValue: TValue;
  public
    procedure ValueFrom<T>(const Value: T);
    property Value: TValue read FValue write FValue;
  end;

implementation

{ TOpenAPIAnyValue }

constructor TOpenAPIAnyValue<T>.Create(const AValue: T);
begin
  FValue := AValue;
end;

function TOpenAPIAnyValue<T>.GetAny: TAny;
begin
  Result := TAny.TypePrimitive;
end;

{ TOpenAPIBoolean }

constructor TOpenAPIBoolean.Create(const AValue: Boolean);
begin
  inherited Create(AValue);
end;

function TOpenAPIBoolean.GetPrimitive: TPrimitive;
begin
  Result := TPrimitive.TypeBoolean;
end;

{ TOpenAPIString }

constructor TOpenAPIString.Create(const AValue: string);
begin
  FValue := AValue;
end;

function TOpenAPIString.GetPrimitive: TPrimitive;
begin
  Result := TPrimitive.TypeString;
end;

{ TOpenAPIInteger }

constructor TOpenAPIInteger.Create(const AValue: Integer);
begin
  FValue := AValue;
end;

function TOpenAPIInteger.GetPrimitive: TPrimitive;
begin
  Result := TPrimitive.TypeInteger;
end;

{ TOpenAPIAny }

procedure TOpenAPIAny.ValueFrom<T>(const Value: T);
begin
  FValue := TValue.From<T>(Value);
end;

end.
