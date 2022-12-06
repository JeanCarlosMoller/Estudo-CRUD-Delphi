unit UdmMoller;

interface

uses
  System.SysUtils,
  System.Classes,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,

  Vcl.Dialogs;

type
  TdmMoller = class(TDataModule)
    cnxBancoDeDados: TFDConnection;
    drvBancoDeDados: TFDPhysMySQLDriverLink;
    wtcBancoDeDados: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnxBancoDeDadosBeforeConnect(Sender: TObject);
    procedure cnxBancoDeDadosAfterConnect(Sender: TObject);
  private
    { Private declarations }
    procedure CriarTabelas();
    procedure InserirDados();
  public
    { Public declarations }
  end;

var
  dmSistema_Moller: TdmMoller;

implementation

uses UresourceUtils, UiniUtils, System.IOUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmMoller.cnxBancoDeDadosAfterConnect(Sender: TObject);
var
  LCaminhoBaseDados: String;
  LCriarBaseDados: Boolean;
begin
  LCaminhoBaseDados := TIniUtils.lerPropriedade(TSECAO.BANCO,
    TPROPRIEDADE.CAMINHO_BANCO);
  LCriarBaseDados := not FileExists(LCaminhoBaseDados, true);

  If LCriarBaseDados then
  begin
    CriarTabelas();
    InserirDados();
  end;
end;

procedure TdmMoller.cnxBancoDeDadosBeforeConnect(Sender: TObject);
var
  LCaminhoBaseDados: String;
  LCriarBaseDados: Boolean;
begin
  LCaminhoBaseDados := TIniUtils.lerPropriedade(TSECAO.BANCO,
    TPROPRIEDADE.CAMINHO_BANCO);
  LCriarBaseDados := not FileExists(LCaminhoBaseDados, true);
  with cnxBancoDeDados do
  begin
    Params.Values['Server'] := TIniUtils.lerPropriedade(TSECAO.BANCO,
      TPROPRIEDADE.SERVIDOR_BANCO);
    Params.Values['User_Name'] := TIniUtils.lerPropriedade(TSECAO.BANCO,
      TPROPRIEDADE.USUARIO_BANCO);
    Params.Values['Password'] := TIniUtils.lerPropriedade(TSECAO.BANCO,
      TPROPRIEDADE.SENHA_BANCO);
    Params.Values['DriverID'] := TIniUtils.lerPropriedade(TSECAO.BANCO,
      TPROPRIEDADE.DRIVER_ID);
    Params.Values['Port'] := TIniUtils.lerPropriedade(TSECAO.BANCO,
      TPROPRIEDADE.PORTA_BANCO);

    if not LCriarBaseDados then
    begin
      Params.Values['Database'] := TIniUtils.lerPropriedade(TSECAO.BANCO,
        TPROPRIEDADE.NOME_BANCO);
    end;
  end;
end;

procedure TdmMoller.CriarTabelas;
// var
// LSqlArquivoScripts: TStringList;
// LCaminhoArquivo: String;
// COMPONENTE CRIADO EM TELA
// LQuery: TFDQuery;
begin
  { *  COMO N�O DEVE SER FEITO
    LSqlArquivoScripts := TStringList.Create;
    //LCaminhoArquivo := 'C:\Users\dtlsilva\Documents\ravin\database\createTable.sql';
    //LSqlArquivoScripts.LoadFromFile(LCaminhoArquivo);
    //cnxBancoDeDados.ExecSQL(LSqlArquivoScripts.Text);
    //FreeAndNil(LSqlArquivoScripts);
    //COMPONENTE CRIADO EM TELA
    //LQuery := TFDQuery.Create(Self);
    //LQuery.Connection := cnxBancoDeDados;
    //LQuery.SQL.Text := 'SELECT * FROM PESSOAS';* }
  try
    cnxBancoDeDados.ExecSQL(TResourcesUtils.carregarArquivoResource
      ('createTable.sql', 'sistema_moller'));
  except
    on E: Exception do
      ShowMessage(E.Message);

  end;
end;

procedure TdmMoller.DataModuleCreate(Sender: TObject);
begin
  if not cnxBancoDeDados.Connected then
  begin
    cnxBancoDeDados.Connected := true;
  end;
end;

procedure TdmMoller.InserirDados;
var
  LSqlArquivoScripts: TStringList;
  LCaminhoArquivo: String;
begin
  LSqlArquivoScripts := TStringList.Create;
  LCaminhoArquivo := 'C:\Users\jcmoller\Documents\sistema_moller\database\inserts.sql';
  LSqlArquivoScripts.LoadFromFile(LCaminhoArquivo);

  // Trye e pressionar TAB cria automaticamente
  try
    cnxBancoDeDados.StartTransaction;
    cnxBancoDeDados.ExecSQL(TResourcesUtils.carregarArquivoResource
      ('createTable.sql', 'sistema_moller'));
    cnxBancoDeDados.Commit;
  except
    on E: Exception do
    Begin
      cnxBancoDeDados.Rollback;
      ShowMessage('N�o foi poss�vel concluir o processo!');
    End;
  end;

  FreeAndNil(LSqlArquivoScripts);
end;

end.
