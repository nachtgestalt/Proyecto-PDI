object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 289
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 56
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 75
    Width = 81
    Height = 81
    BorderStyle = bsNone
    ColCount = 3
    DefaultColWidth = 24
    FixedCols = 0
    RowCount = 3
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    PopupMenu = PopupMenu1
    ScrollBars = ssNone
    TabOrder = 0
  end
  object TrackBar1: TTrackBar
    Left = 8
    Top = 24
    Width = 150
    Height = 26
    Max = 7
    Min = 3
    Position = 3
    TabOrder = 1
    OnChange = TrackBar1Change
  end
  object BitBtn1: TBitBtn
    Left = 272
    Top = 224
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 384
    Top = 224
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 3
  end
  object PopupMenu1: TPopupMenu
    Left = 32
    Top = 184
    object Kirsch1: TMenuItem
      Caption = 'Laplaciano'
      OnClick = Kirsch1Click
    end
    object Kirch1: TMenuItem
      Caption = 'Kirch'
      OnClick = Kirch1Click
    end
    object Robinson1: TMenuItem
      Caption = 'Robinson'
      OnClick = Robinson1Click
    end
  end
end
