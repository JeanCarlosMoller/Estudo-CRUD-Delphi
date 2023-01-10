program JCMöller;



uses
  Vcl.Forms,
  SistemaMoller.View.Principal in 'src\View\SistemaMoller.View.Principal.pas' {frmPrincipal},
  SistemaMoller.View.CadastroPadrao in 'src\View\SistemaMoller.View.CadastroPadrao.pas' {frmCadastroPadrao},
  SistemaMoller.View.Splash in 'src\View\SistemaMoller.View.Splash.pas' {frmSplash},
  SistemaMoller.Model.Conexao in 'src\Model\SistemaMoller.Model.Conexao.pas' {dmConexao: TDataModule},
  SistemaMoller.View.Usuarios in 'src\View\SistemaMoller.View.Usuarios.pas' {frmUsuarios},
  SistemaMoller.Model.Usuarios in 'src\Model\SistemaMoller.Model.Usuarios.pas' {dmUsuarios: TDataModule},
  SistemaMoller.Utilitarios in 'src\Util\SistemaMoller.Utilitarios.pas',
  SistemaMoller.View.Login in 'src\View\SistemaMoller.View.Login.pas' {frmLogin},
  SistemaMoller.Model.Entidades.Usuario in 'src\Model\Entidades\SistemaMoller.Model.Entidades.Usuario.pas',
  SistemaMoller.Model.Sistema in 'src\Model\SistemaMoller.Model.Sistema.pas' {dmSistema: TDataModule},
  SistemaMoller.View.RedefinirSenha in 'src\View\SistemaMoller.View.RedefinirSenha.pas' {frmRedefinirSenha};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmUsuarios, dmUsuarios);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmCadastroPadrao, frmCadastroPadrao);
  Application.CreateForm(TfrmUsuarios, frmUsuarios);
  Application.CreateForm(TdmSistema, dmSistema);
  Application.Run;
end.
