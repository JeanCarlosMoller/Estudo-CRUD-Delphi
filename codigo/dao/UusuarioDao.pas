unit UusuarioDao;

interface

uses
  System.SysUtils,
  Uusuario,
  FireDAC.Comp.Client,
  System.Generics.Collections;

type
  TUsuarioDAO = class
  private

  protected

  public
    function BuscarUsuarioPorLoginSenha(PLogin: String; PSenha: String)
      : TUsuario;
    function BuscarTodosUsuarios(): TList<TUsuario>;
    procedure InserirUsuario(PUsuario: TUsuario);
  end;

implementation

{ TUsuarioDAO }

uses UdmMoller;

function TUsuarioDAO.BuscarTodosUsuarios: TList<TUsuario>;
var
  LQuery: TFDQuery;
  LUsuario: TUsuario;
  LLista: TList<TUsuario>;
  I : Integer;
begin
  // Setar as informações da query e buscar os dados do banco
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmSistema_Moller.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT * FROM usuario';
  LQuery.Open();

  LLista := TList<TUsuario>.Create();

  LQuery.First;

  // Mapear os dados carregados para objeto
  while not LQuery.Eof do
  begin
    LUsuario := TUsuario.Create();
    LUsuario.id := LQuery.FieldByName('id').AsInteger;
    LUsuario.login := LQuery.FieldByName('login').AsString;
    LUsuario.senha := LQuery.FieldByName('senha').AsString;
    LUsuario.pessoaId := LQuery.FieldByName('pessoaId').AsInteger;
    LUsuario.criadoEm := LQuery.FieldByName('criadoEm').AsDateTime;
    LUsuario.criadoPor := LQuery.FieldByName('criadoPor').AsString;
    LUsuario.alteradoEm := LQuery.FieldByName('alteradoEm').AsDateTime;
    LUsuario.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;

    LLista.add(LUsuario);
    LQuery.Next;
  end;

  Result:= LLista;

  FreeAndNil(LQuery);
end;


function TUsuarioDAO.BuscarUsuarioPorLoginSenha(PLogin, PSenha: String)
  : TUsuario;

var
  LQuery: TFDQuery;
  LUsuario: TUsuario;

begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmSistema_Moller.cnxBancoDeDados;

  LQuery.SQL.Text := 'SELECT * FROM usuario ' +
    ' WHERE login = :login AND senha = :senha';

  LQuery.ParamByName('login').AsString := PLogin;
  LQuery.ParamByName('senha').AsString := PSenha;
  LQuery.Open();

  LUsuario := nil;

  if not LQuery.IsEmpty then
  begin
    LUsuario := TUsuario.Create;
    LUsuario.id := LQuery.FieldByName('id').AsInteger;
    LUsuario.login := LQuery.FieldByName('login').AsString;
    LUsuario.senha := LQuery.FieldByName('senha').AsString;
    LUsuario.criadoEm := LQuery.FieldByName('criadoEm').AsDateTime;
    LUsuario.criadoPor := LQuery.FieldByName('criadoPor').AsString;
    LUsuario.alteradoEm := LQuery.FieldByName('alteradoEm').AsDateTime;
    LUsuario.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;
  end;

  LQuery.Close();
  FreeAndNil(LQuery);
  Result := LUsuario;
end;

procedure TUsuarioDAO.InserirUsuario(PUsuario: TUsuario);
var
  LQuery: TFDQuery;

begin
  LQuery := TFDQuery.Create(nil);

  with LQuery do
  begin
    Connection := dmSistema_Moller.cnxBancoDeDados;
    SQL.Add('INSERT INTO usuario ');
    SQL.Add('(login, senha, criadoEm, criadoPor, ');
    SQL.Add('alteradoEm, alteradoPor)');
    SQL.Add(' VALUES (:login, :senha, ');
    SQL.Add(' :criadoEm, :criadoPor, :alteradoEm, :alteradoPor)');

    ParamByName('login').AsString := PUsuario.login;
    ParamByName('senha').AsString := PUsuario.senha;
    ParamByName('criadoEm').AsDateTime := PUsuario.criadoEm;
    ParamByName('criadoPor').AsString := PUsuario.criadoPor;
    ParamByName('alteradoEm').AsDateTime := PUsuario.alteradoEm;
    ParamByName('alteradoPor').AsString := PUsuario.alteradoPor;

    ExecSQL();
  end;

  FreeAndNil(LQuery);

end;

end.
