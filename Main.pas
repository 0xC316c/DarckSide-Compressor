unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.IOUtils,
  System.Variants, System.StrUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo,
  WinApi.Windows, WinApi.ShellApi, WinApi.TlHelp32,
  FMX.Layouts, FMX.ListBox, FMX.Menus, FMX.Objects, FMX.TabControl,
  Func, FMX.Memo.Types;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    StyleBook1: TStyleBook;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Edit1Typing(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage('GUI Based Compressor by Darck Team' + #13#10 + #13#10 +
    'Programmers: Jiva Newstone & PsYcHo_RaGE' + #13#10 +
    'Designer: Jiva Newstone' + #13#10 + 'Testers: PsYcHo_RaGE & ScOOt3r');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Lines.SaveToFile(IncludeTrailingPathDelimiter(GetCurrentDir) +
    ('bin\arc.ini'));
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ShowMessage('Coming Soon! Hold on.');
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  ListBox1.Items.Delete(ListBox1.ItemIndex);
end;

procedure TForm1.Edit1Typing(Sender: TObject);
begin
  Edit2.Text := Edit1.Text;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If DirectoryExists(IncludeTrailingPathDelimiter(GetCurrentDir) +
    ('temp-Darck\')) then
    TDirectory.Delete(IncludeTrailingPathDelimiter(GetCurrentDir) + ('temp-Darck\'),true)
  else
    ShowMessage('Failed to the remove ''temp-Darck'' Directory with an error: '
      + IntToStr(GetLastError));
  ListBox1.Clear;
  Removetmpfiles;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if DirectoryExists(IncludeTrailingPathDelimiter(GetCurrentDir) +
    ('temp-Darck\')) then
    TDirectory.Delete(IncludeTrailingPathDelimiter(GetCurrentDir) + ('temp-Darck\'),true)
  else
    CreateDir(IncludeTrailingPathDelimiter(GetCurrentDir) + ('temp-Darck\'));
  if FileExists(IncludeTrailingPathDelimiter(GetCurrentDir) + ('bin\arc.ini'))
  then
    Memo1.Lines.LoadFromFile(IncludeTrailingPathDelimiter(GetCurrentDir) +
      ('bin\arc.ini'));
  Edit1.Text := ('data1');
  Edit2.Text := ('data1');
  Edit3.Text := (RandomizeMethods(Random(10)));
  Removetmpfiles;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  I, J, InFound, OutFound, Found: Integer;
begin
  InFound := 0;
  OutFound := 0;
  Found := 0;
  for J := 0 to ListBox1.Items.Count - 1 do
  begin
    if ContainsText(ListBox1.ListItems[J].Text, Edit2.Text) then
      OutFound := 1
    else
      OutFound := 0;
  end;

  for I := 0 to ListBox1.Items.Count - 1 do
  begin
    if ContainsText(ListBox1.ListItems[I].Text, Edit1.Text) then
      InFound := 1
    else
      InFound := 0;
  end;
  Found := InFound + OutFound;
  if (Found) = 0 then
  begin
    ListBox1.Items.Add(' a -ep1 -r -ed --dirs -s; -lc-  -m' + Edit3.Text +
      ' "Output\' + Edit2.Text + '.drk" "' + Edit1.Text + '\*" -wtemp-Darck\');
  end;

end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if ListBox1.ItemIndex > -1 then
    ListBox1.Items.Delete(ListBox1.ItemIndex)
  else
    ListBox1.Items.Delete(ListBox1.Count - 1);
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var
  I: Integer;
  QueueList: string;
begin
  Removetmpfiles;
  for I := 0 to ListBox1.Count - 1 do
  begin
    SpeedButton3.Enabled := False;
    QueueList := PChar(ListBox1.ListItems[0].Text);
    if ExecuteQueue(QueueList, ListBox1) then
    begin
      ListBox1.ItemIndex := 1;
    end
    else
      ListBox1.Items.Delete(0);
  end;
  SpeedButton3.Enabled := True;
  {Recheck}
  Removetmpfiles;
  if (ListBox1.Count) > 0 then
  begin
  for I := 0 to ListBox1.Count - 1 do
  begin
    SpeedButton3.Enabled := False;
    QueueList := PChar(ListBox1.ListItems[0].Text);
    if ExecuteQueue(QueueList, ListBox1) then
    begin
      ListBox1.ItemIndex := 1;
    end
    else
      ListBox1.Items.Delete(0);
  end;
  SpeedButton3.Enabled := True;
  end;
  {}
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
Edit3.Text := (RandomizeMethods(Random(10)));
end;

end.
