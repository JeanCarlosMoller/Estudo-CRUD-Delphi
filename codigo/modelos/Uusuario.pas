unit Uusuario;

interface

type
  TUsuario = class

    private
    Fid: Integer;
    FalteradoPor: String;
    FalteradoEm: TDateTime;
    FcriadoPor: String;
    FcriadoEm: TDateTime;
    Fsenha: String;
    FpessoaId: Integer;
    Flogin: String;
    Fnome: String;

    protected

    public
    property id: Integer read Fid write Fid;
    property nome: String read Fnome write Fnome;
    property login: String read Flogin write Flogin;
    property senha: String read Fsenha write Fsenha;
    property pessoaId: Integer read FpessoaId write FpessoaId;
    property criadoEm: TDateTime read FcriadoEm write FcriadoEm;
    property criadoPor: String read FcriadoPor write FcriadoPor;
    property alteradoEm: TDateTime read FalteradoEm write FalteradoEm;
    property alteradoPor: String read FalteradoPor write FalteradoPor;

  end;

implementation

end.
