unit UfrmSplash;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmSplash = class(TForm)
    pnlFundo: TPanel;
    tmrSplash: TTimer;
    Image1: TImage;
    ProgressBar1: TProgressBar;
    Panel1: TPanel;
    lblInformativoCarregamento: TLabel;

    procedure tmrSplashTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    Inicialized: Boolean;
    procedure InicializarAplicacao();
    procedure SetarFormPrincipal(NewMainForm: TForm);

    procedure AtualizarStatus(Mensagem: String);

  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

uses UfrmLogin;

procedure TfrmSplash.AtualizarStatus(Mensagem: String);
begin
  lblInformativoCarregamento.Caption := Mensagem;
end;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  {Inicialized := false;
  tmrSplash.Enabled := false;
   tmrSplash.Interval := 50;  }
end;

procedure TfrmSplash.FormPaint(Sender: TObject);
begin
  // tmrSplash.Enabled := not Inicialized;
end;

procedure TfrmSplash.InicializarAplicacao;
begin
  if not Assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;

  SetarFormPrincipal(frmLogin);
  frmLogin.Show();

  Close;
end;

procedure TfrmSplash.tmrSplashTimer(Sender: TObject);
begin
  if ProgressBar1.Position <= 1000 then
  begin
    ProgressBar1.StepIt;
    case ProgressBar1.Position of
      50:
        AtualizarStatus('Carregando dependências...');
      250:
        AtualizarStatus('Conectando ao banco de dados...');
      450:
        AtualizarStatus('Carregando as configurações...');
      750:
        AtualizarStatus('Iniciando o sistema...');
    end;
  end;
  if ProgressBar1.Position = 1000 then
  begin
    InicializarAplicacao;
  end;
end;

procedure TfrmSplash.SetarFormPrincipal(NewMainForm: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := NewMainForm;
end;

end.
