unit SistemaMoller.View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls;

type
  TfrmLogin = class(TForm)
    pnlEsquerda: TPanel;
    imgLogo: TImage;
    pnlPrincipal: TPanel;
    Panel3: TPanel;
    edtSenha: TEdit;
    edtLogin: TEdit;
    btnEntrar: TButton;
    imgUserLogo: TImage;
    procedure btnEntrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  SistemaMoller.Model.Usuarios, SistemaMoller.Model.Sistema;

{$R *.dfm}

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
  if Trim(edtLogin.Text) = '' then
  begin
    edtLogin.SetFocus;
    Application.MessageBox('Informe o seu usu?rio.', 'Aten??o', MB_Ok + MB_ICONWARNING);
    Abort;
  end;
  if Trim(edtSenha.Text) = '' then
  begin
    edtLogin.SetFocus;
    Application.MessageBox('Informe a sua senha.', 'Aten??o', MB_Ok + MB_ICONWARNING);
    Abort;
  end;
  try
    dmUsuarios.EfetuarLogin(Trim(edtLogin.Text), Trim(edtSenha.Text));
    dmSistema.DataUltimoAcesso(Now);
    dmSistema.UsuarioUltimoAcesso(dmUsuarios.GetUsuarioLogado.Login);
    ModalREsult := mrOk
  except
    on Erro: Exception do
    begin
      Application.MessageBox(PwideChar(Erro.Message), 'Aten??o', MB_Ok + MB_ICONWARNING);
      edtLogin.SetFocus;
    end;
  end;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  edtLogin.Text := dmSistema.UsuarioUltimoAcesso;
end;

end.
