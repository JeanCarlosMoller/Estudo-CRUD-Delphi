program JCMöller;

uses
  Vcl.Forms,
  UfrmLogin in '..\codigo\formulario\UfrmLogin.pas' {frmLogin},
  UusuarioDao in '..\codigo\dao\UusuarioDao.pas',
  Uusuario in '..\codigo\modelos\Uusuario.pas',
  udmMoller in '..\database\udmMoller.pas' {dmMoller: TDataModule},
  UresourceUtils in '..\codigo\Utils\UresourceUtils.pas',
  UfrmSplash in '..\codigo\formulario\UfrmSplash.pas' {frmSplash},
  UiniUtils in '..\codigo\Utils\UiniUtils.pas',
  UfrmPainelGestao in '..\codigo\formulario\UfrmPainelGestao.pas' {frmPainelGestao},
  UformUtils in '..\codigo\Utils\UformUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TdmMoller, dmSistema_Moller);
  Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
  Application.CreateForm(TfrmLogin, frmLogin);

  Application.Run;
end.
