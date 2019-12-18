object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Demonstrations'
  ClientHeight = 121
  ClientWidth = 694
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbCount: TLabel
    Left = 16
    Top = 48
    Width = 37
    Height = 13
    Caption = 'lbCount'
  end
  object X1: TLabel
    Left = 152
    Top = 48
    Width = 12
    Height = 13
    Caption = 'X1'
  end
  object Y1: TLabel
    Left = 216
    Top = 48
    Width = 12
    Height = 13
    Caption = 'Y1'
  end
  object X2: TLabel
    Left = 296
    Top = 48
    Width = 12
    Height = 13
    Caption = 'X2'
  end
  object Y2: TLabel
    Left = 368
    Top = 48
    Width = 12
    Height = 13
    Caption = 'Y2'
  end
  object Stage1: TButton
    Left = 64
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Go'
    TabOrder = 0
    OnClick = Stage1Click
  end
  object lbX1: TEdit
    Left = 144
    Top = 8
    Width = 56
    Height = 24
    TabOrder = 1
    Text = 'lbX1'
  end
  object lbY1: TEdit
    Left = 208
    Top = 8
    Width = 64
    Height = 24
    TabOrder = 2
    Text = 'lbY1'
  end
  object lbX2: TEdit
    Left = 296
    Top = 8
    Width = 64
    Height = 24
    TabOrder = 3
    Text = 'lbX2'
  end
  object lbY2: TEdit
    Left = 368
    Top = 8
    Width = 72
    Height = 24
    TabOrder = 4
    Text = 'lbY2'
  end
  object lbNumberStep: TEdit
    Left = 8
    Top = 8
    Width = 48
    Height = 24
    TabOrder = 5
    Text = '0'
  end
  object btSet: TButton
    Left = 448
    Top = 8
    Width = 72
    Height = 25
    Caption = 'Set'
    TabOrder = 6
    OnClick = btSetClick
  end
  object btleft: TButton
    Left = 528
    Top = 8
    Width = 72
    Height = 25
    Caption = '<'
    TabOrder = 7
    OnClick = btleftClick
  end
  object btRight: TButton
    Left = 608
    Top = 8
    Width = 72
    Height = 25
    Caption = '>'
    TabOrder = 8
    OnClick = btRightClick
  end
  object btADD: TButton
    Left = 448
    Top = 48
    Width = 75
    Height = 25
    Caption = 'ADD'
    TabOrder = 9
    OnClick = btADDClick
  end
end
