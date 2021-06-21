object Form1: TForm1
  Left = 608
  Top = 201
  Caption = 'A Checker'
  ClientHeight = 530
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 131
    Width = 639
    Height = 322
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 143
    ExplicitTop = 0
    ExplicitWidth = 641
    ExplicitHeight = 769
    ControlData = {
      4C0000000B420000482100000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Memo1: TMemo
    Left = 0
    Top = 493
    Width = 639
    Height = 37
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    Visible = False
    WordWrap = False
    ExplicitTop = 280
    ExplicitWidth = 984
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 639
    Height = 105
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 984
    object Edit1: TEdit
      Left = 1
      Top = 1
      Width = 637
      Height = 21
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 982
    end
    object StringGrid1: TStringGrid
      Left = 1
      Top = 22
      Width = 637
      Height = 82
      Align = alClient
      ColCount = 2
      DefaultColWidth = 500
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = StringGrid1Click
      ExplicitTop = 21
      ExplicitWidth = 982
    end
  end
  object Memo2: TMemo
    Left = 0
    Top = 453
    Width = 639
    Height = 40
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 3
    Visible = False
    WordWrap = False
    ExplicitTop = 240
    ExplicitWidth = 984
  end
  object Panel2: TPanel
    Left = 0
    Top = 105
    Width = 639
    Height = 26
    Align = alTop
    TabOrder = 4
    ExplicitWidth = 984
    object SpeedButton1: TSpeedButton
      Left = 241
      Top = 1
      Width = 120
      Height = 24
      Align = alLeft
      Caption = 'Paused'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 364
      Top = 4
      Width = 71
      Height = 18
      Align = alLeft
      Caption = 'Timer Interval:'
      ExplicitHeight = 13
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 487
      Top = 4
      Width = 78
      Height = 18
      Align = alLeft
      Caption = 'Next update in: '
      ExplicitLeft = 646
      ExplicitHeight = 13
    end
    object Button2: TButton
      Left = 1
      Top = 1
      Width = 120
      Height = 24
      Align = alLeft
      Caption = 'Get Selected Status'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 121
      Top = 1
      Width = 120
      Height = 24
      Align = alLeft
      Caption = 'Get All Status'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Edit2: TEdit
      AlignWithMargins = True
      Left = 441
      Top = 4
      Width = 40
      Height = 18
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 2
      Text = '30'
      OnChange = Edit2Change
    end
    object Edit3: TEdit
      AlignWithMargins = True
      Left = 571
      Top = 4
      Width = 64
      Height = 18
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      ExplicitLeft = 680
      ExplicitWidth = 300
    end
  end
  object Memo3: TMemo
    Left = 0
    Top = 131
    Width = 639
    Height = 322
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 5
    ExplicitTop = 1203
    ExplicitWidth = 984
    ExplicitHeight = 89
  end
  object PopupMenu1: TPopupMenu
    Left = 32
    Top = 208
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1800000
    OnTimer = Button1Click
    Left = 568
    Top = 352
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 672
    Top = 160
  end
  object XMLDocument1: TXMLDocument
    Left = 464
    Top = 264
    DOMVendorDesc = 'MSXML'
  end
end
