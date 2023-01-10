unit SistemaMoller.View.RedefinirSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  SistemaMoller.Model.Entidades.Usuario;

type
  TfrmRedefinirSenha = class(TForm)
    Panel1: TPanel;
    lblRdefinicaoSenha: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    edtSenha: TEdit;
    edtConfirmarSenha: TEdit;
    Panel5: TPanel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    FUsuario: TModelEntidadeUsuario;
    procedure SetUsuario(const Value: TModelEntidadeUsuario);
    { Private declarations }
  public
    { Public declarations }
    property Usuario : TModelEntidadeUsuario read FUsuario write SetUsuario;
  end;

var
  frmRedefinirSenha: TfrmRedefinirSenha;

implementation

uses
  SistemaMoller.Model.Usuarios;

{$R *.dfm}

procedure TfrmRedefinirSenha.btnConfirmarClick(Sender: TObject);
begin
  edtSenha.Text := Trim(edtSenha.Text);
  edtConfirmarSenha.Text := Trim(edtConfirmarSenha.Text);

  if edtSenha.Text = '' then
  begin
    edtSenha.SetFocus;
    Application.MessageBox('Informe a sua nova senha', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if edtConfirmarSenha.Text = '' then
  begin
    edtConfirmarSenha.SetFocus;
    Application.MessageBox('Confirme a sua nova senha', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if edtSenha.Text <> edtConfirmarSenha.Text then
  begin
    edtConfirmarSenha.SetFocus;
    Application.MessageBox('Senha diferente da confirmação', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  Usuario.Senha := EdtSenha.Text;
  dmUsuarios.RedefinirSenha(Usuario);
  Application.MessageBox('Senha alterada com Sucesso', 'Sucesso', MB_OK + MB_ICONINFORMATION);
  ModalResult := mrOk;

end;

procedure TfrmRedefinirSenha.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmRedefinirSenha.SetUsuario(const Value: TModelEntidadeUsuario);
begin
  FUsuario := Value;
end;

end.
