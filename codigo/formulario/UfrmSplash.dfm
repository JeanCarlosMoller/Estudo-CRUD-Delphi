object frmSplash: TfrmSplash
  Left = 0
  Top = 0
  Caption = 'frmSplash'
  ClientHeight = 463
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 577
    Height = 465
    Caption = 'pnlFundo'
    TabOrder = 0
  end
  object tmrSplash: TTimer
    Interval = 2000
    OnTimer = tmrSplashTimer
    Left = 392
    Top = 272
  end
end