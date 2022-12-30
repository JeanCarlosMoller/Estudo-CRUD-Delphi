object dmMoller: TdmMoller
  OldCreateOrder = False
  Height = 438
  Width = 456
  object cnxBancoDeDados: TFDConnection
    Params.Strings = (
      'Port='
      'DriverID=MySQL')
    AfterConnect = cnxBancoDeDadosAfterConnect
    BeforeConnect = cnxBancoDeDadosBeforeConnect
    Left = 80
    Top = 96
  end
  object drvBancoDeDados: TFDPhysMySQLDriverLink
    VendorLib = 'C:\GIT\Estudo-CRUD-Delphi\bibliotecas\libmysql.dll'
    Left = 80
    Top = 160
  end
  object wtcBancoDeDados: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 80
    Top = 224
  end
end
