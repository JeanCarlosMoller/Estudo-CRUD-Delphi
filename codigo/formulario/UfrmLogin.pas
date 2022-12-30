unit UfrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.DBCtrls;

type
  TfrmLogin = class(TForm)
    edt_usuario: TEdit;
    edt_senha: TEdit;
    btn_login: TButton;
    Panel1: TPanel;
    btn_criarConta: TButton;
    lbl_esqueceuSenha: TLabel;
    Panel2: TPanel;
    Image1: TImage;
    procedure btn_loginClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbl_esqueceuSenhaClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses Uusuario, UiniUtils, UusuarioDao, UfrmPainelGestao, UformUtils;

procedure TfrmLogin.btn_loginClick(Sender: TObject);
var
  LDao: TUsuarioDao;
  LUsuario: TUsuario;

  LLogin: String;
  LSenha: String;
begin

  LDao := TUsuarioDao.Create;

  LLogin := edt_usuario.Text;
  LSenha := edt_senha.Text;

  LUsuario := LDao.BuscarUsuarioPorLoginSenha(LLogin, LSenha);

  if Assigned(LUsuario) then
  begin
    // REGISTRAR DATA E HORA LOGIN
    TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS,
      TPROPRIEDADE.DATAHORA_ULTIMO_LOGIN, DateTimeToStr(Now));

    // Cpmseguiu Logar
    TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO,
      TIniUtils.VALOR_VERDADEIRO);

    if not Assigned(frmPainelGestao) then
    begin
      Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
    end;

    TFormUtils.SetarFormularioPrincipal(frmPainelGestao);
    frmPainelGestao.Show();

    FreeAndNil(LDao);
    FreeAndNil(LUsuario);

    Close();
  end
  else
  begin
    FreeAndNil(LDao);
    ShowMessage('Login e /ou senha inv�lidos');
  end;
  FreeAndNil(LDao);
end;


procedure TfrmLogin.Button1Click(Sender: TObject);
var
  LUsuario: TUsuario;
  LDao: TUsuarioDao;
begin
  LUsuario := TUsuario.Create();
  LUsuario.login := 'teste';
  LUsuario.senha := '123';
  LUsuario.pessoaId := 1;
  LUsuario.criadoEm := Now();
  LUsuario.criadoPor := 'marcio';
  LUsuario.alteradoEm := Now();
  LUsuario.alteradoPor := 'marcio';

  LDao := TUsuarioDao.Create();
  LDao.InserirUsuario(LUsuario);

  FreeAndNil(LDao);
  FreeAndNil(LUsuario);

end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  lbl_esqueceuSenha.font.Color := clblue;
end;

procedure TfrmLogin.lbl_esqueceuSenhaClick(Sender: TObject);

var
  LDao: TUsuarioDao;
  LUsuario: TUsuario;

  LLogin: String;

  InputString: string;

begin
  InputString:= InputBox('Autentica��o de usu�rio', 'Informe seu c�digo: ', '');


begin

  LDao := TUsuarioDao.Create;

  LLogin := InputString;

  LUsuario := LDao.BuscarUsuarioCredencial(LLogin);

  if Assigned(LUsuario) then
  begin
    // REGISTRAR DATA E HORA LOGIN
    TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS,
      TPROPRIEDADE.DATAHORA_ULTIMO_LOGIN, DateTimeToStr(Now));

    // Cpmseguiu Logar
    TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO,
      TIniUtils.VALOR_VERDADEIRO);

    if not Assigned(frmPainelGestao) then
    begin
      Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
    end;

    TFormUtils.SetarFormularioPrincipal(frmPainelGestao);
    frmPainelGestao.Show();

    FreeAndNil(LDao);
    FreeAndNil(LUsuario);

    Close();
  end
  else
  begin
    FreeAndNil(LDao);
    ShowMessage('Credencial invalida');
  end;
  FreeAndNil(LDao);

end;

  end;


end.
