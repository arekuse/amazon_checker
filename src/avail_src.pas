unit avail_src;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw,
  Vcl.ExtCtrls, strutils, mshtml, WinInet, Vcl.Menus, Vcl.Grids, Vcl.Buttons,
  Vcl.MPlayer, Vcl.Samples.Gauges, XMLIntf, XMLDoc, Xml.xmldom, Xml.Win.msxmldom;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    Memo1: TMemo;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    Button2: TButton;
    Memo2: TMemo;
    Panel2: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    SpeedButton1: TSpeedButton;
    Edit2: TEdit;
    Timer2: TTimer;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Memo3: TMemo;
    XMLDocument1: TXMLDocument;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  cur_article_name: string ='';
  tick : integer;
  article_available: string='Auf Lager';
  article_not_available: string='Derzeit nicht verfügbar';
  settings: IXMLNode;
implementation

uses wbfuncs;

{$R *.dfm}

function GetUrlContent(const Url: string): UTF8String;
var
  NetHandle: HINTERNET;
  UrlHandle: HINTERNET;
  Buffer: array[0..1023] of byte;
  BytesRead: dWord;
  StrBuffer: UTF8String;
begin
  Result := '';
  NetHandle := InternetOpen('Delphi 2009', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if Assigned(NetHandle) then
    try
      UrlHandle := InternetOpenUrl(NetHandle, PChar(Url), nil, 0, INTERNET_FLAG_RELOAD, 0);
      if Assigned(UrlHandle) then
        try
          repeat
            InternetReadFile(UrlHandle, @Buffer, SizeOf(Buffer), BytesRead);
            SetString(StrBuffer, PAnsiChar(@Buffer[0]), BytesRead);
            Result := Result + StrBuffer;
          until BytesRead = 0;
        finally
          InternetCloseHandle(UrlHandle);
        end
      else
        raise Exception.CreateFmt('Cannot open URL %s', [Url]);
    finally
      InternetCloseHandle(NetHandle);
    end
  else
    raise Exception.Create('Unable to initialize Wininet');
end;

type
  TSearchOption = (soIgnoreCase, soFromStart, soWrap);
  TSearchOptions = set of TSearchOption;


function SearchText(
    Control: TCustomEdit;
    Search: string;
    SearchOptions: TSearchOptions): Boolean;
var
  Text: string;
  Index: Integer;
begin
  if soIgnoreCase in SearchOptions then
  begin
    Search := UpperCase(Search);
    Text := UpperCase(Control.Text);
  end
  else
    Text := Control.Text;

  Index := 0;
  if not (soFromStart in SearchOptions) then
    Index := PosEx(Search, Text,
         Control.SelStart + Control.SelLength + 1);

  if (Index = 0) and
      ((soFromStart in SearchOptions) or
       (soWrap in SearchOptions)) then
    Index := PosEx(Search, Text, 1);

  Result := Index > 0;
  if Result then
  begin
    Control.SelStart := Index - 1;
    Control.SelLength := Length(Search);
  end;
end;

function GetHTML(w: TWebBrowser): String;
Var
  e: IHTMLElement;
begin
  Result := '';
  if Assigned(w.Document) then
  begin
     e := (w.Document as IHTMLDocument2).body;

     while e.parentElement <> nil do
     begin
       e := e.parentElement;
     end;
     Result := e.outerHTML;
  end;
end;

function MultiStringReplace(const S : string; OldPattern, NewPattern : array of string;
  Flags : TReplaceFlags): string;
var
  i : Integer;
begin
  Assert(Length(OldPattern) = Length(NewPattern), 'Pattern array lengths differ');
  Result := S;
  for i := Low(OldPattern) to High(OldPattern) do
    Result := StringReplace(Result, OldPattern[i], NewPattern[i], Flags);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
begin
tick:=strtoint(edit2.Text)*60000;
for i := 0 to stringgrid1.RowCount-1 do
begin
  edit1.Text:=stringgrid1.Cells[1,i];
  cur_article_name:=stringgrid1.Cells[0,i];
  button2.Click;
  sleep(5000);
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var start_pos: integer;
    StartPos: integer;
  FoundPos: integer;
  i: integer;
  tries: integer;
begin
memo1.clear;
memo2.Clear;
panel1.Caption:='';
tries:=1;

repeat
try
memo1.Text:=GetUrlContent(edit1.Text);
sleep(3000);
tries:=tries+1;
finally
end;
until (memo1.Text<>'') or (tries = 3);

if memo1.Text<>'' then
begin

if (SearchText(memo1,article_available,[])) then
begin
memo3.lines.add(cur_article_name + ' - '+ FormatDateTime('yyyy-mm-dd hh:nn:ss', now)+': '+article_available);
end
else if (SearchText(memo1,article_not_available,[])) then
begin
memo3.lines.add(cur_article_name + ' - '+ FormatDateTime('yyyy-mm-dd hh:nn:ss', now)+': '+article_not_available);
end
else
memo3.lines.add(cur_article_name + ' - '+ FormatDateTime('yyyy-mm-dd hh:nn:ss', now)+': unknown');

end
else
memo3.lines.add(cur_article_name + ' - '+ FormatDateTime('yyyy-mm-dd hh:nn:ss', now)+': could not be retreived');

panel1.Caption:='';
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
if edit2.text<>'' then
begin
timer1.Interval:=strtoint(edit2.Text)*60000;
timer1.Enabled:=false;
speedbutton1.Caption:='Paused';
speedbutton1.Font.Color:=clgreen;
edit3.Text:='--';
end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
memo3.lines.SaveToFile('close.txt');
end;

procedure TForm1.FormCreate(Sender: TObject);
var
name: string;
link: string;
positive: string;
negative: string;
begin
StringGrid1.ColWidths[0] := 200;
StringGrid1.ColWidths[1] := 770;

  XMLDocument1.FileName :='settings.xml';
  XMLDocument1.Active := True;
  try
    settings := XMLDocument1.DocumentElement;
    name := settings.ChildNodes['name'].Text;
    link := settings.ChildNodes['link'].Text;
    positive := settings.ChildNodes['positive'].Text;
    negative  := settings.ChildNodes['negative'].Text;
  finally
    XMLDocument1.Active := False;
  end;

stringgrid1.Cells[0,0]:=name;
stringgrid1.Cells[1,0]:=link;
article_available:=positive;
article_not_available:=negative;
{
//test
stringgrid1.Cells[0,0]:='PS4';
stringgrid1.Cells[1,0]:='https://www.amazon.de/PlayStation-Pro-Konsole-schwarz-Naughty/dp/B085PB4B6J/ref=zg_bs_2583845031_3?_encoding=UTF8&psc=1&refRID=QWRPCBCKX92F6N91PJZP';
}



end;

procedure TForm1.FormResize(Sender: TObject);
begin
StringGrid1.ColWidths[0] := 200;
StringGrid1.ColWidths[1] := form1.Width-StringGrid1.ColWidths[0]-30;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
if speedbutton1.Caption = 'Paused' then
begin
tick:=strtoint(edit2.Text)*60000;
timer1.Enabled:=true;
speedbutton1.Caption:='Checking...';
speedbutton1.Font.Color:=clred;
end
else
begin
timer1.Enabled:=false;
speedbutton1.Caption:='Paused';
speedbutton1.Font.Color:=clgreen;
end;
end;

procedure TForm1.StringGrid1Click(Sender: TObject);
begin
button2.Enabled:=true;
cur_article_name:=stringgrid1.Cells[0, stringgrid1.Row];
edit1.Text:=stringgrid1.Cells[1, stringgrid1.Row];
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
if timer1.Enabled then
begin
tick:=tick - 1000;
edit3.Text:=inttostr(tick div 60000);
end;
end;

end.
