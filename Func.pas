unit Func;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.IOUtils,
  System.Variants, FMX.ListBox, WinAPI.ShellAPI, WinAPI.Windows, FMX.Forms;

function RandomizeMethods(Methods: Integer): string;
procedure Removetmpfiles;
function ExecuteQueue(ParamString: string; AListBox: TListBox): Boolean;

implementation

procedure Removetmpfiles;
var
  Files: TStringDynArray;
  Path: string;
  I: Integer;
begin
  Path := IncludeTrailingPathDelimiter(GetCurrentDir) + 'Output\';
  if DirectoryExists(Path) then
  begin
    Files := TDirectory.GetFiles(Path, '*.tmp*',
      TSearchOption.soAllDirectories);
    for I := Low(Files) to High(Files) do
    begin
      System.SysUtils.DeleteFile(Files[I]);
    end;
  end;
end;

function RandomizeMethods(Methods: Integer): string;
begin
  case Methods of
    0:
      begin
        Result := 'srep+rzr';
      end;
    1:
      begin
        Result := 'srep+lolz';
      end;
    2:
      begin
        Result := 'oo2reck+srep+lolz';
      end;
    3:
      begin
        Result := 'xzlib+srep+lolz';
      end;
    4:
      begin
        Result := 'bcmx+srep+lolz';
      end;
    5:
      begin
        Result := 'uelr+srep+lolz';
      end;
    6:
      begin
        Result := 'afr+srep+lolz';
      end;
    7:
      begin
        Result := 'xzlibpf+srep+lolz';
      end;
    8:
      begin
        Result := 'mpz+srep+lolz';
      end;
    9:
      begin
        Result := 'precompx+srep+lolz';
      end;
    10:
      begin
        Result := 'bpk';
      end;
  end;
end;

function ExecuteQueue(ParamString: string; AListBox: TListBox): Boolean;
var
  SEInfo: TShellExecuteInfo;
  ExitCode: DWORD;
  ExecuteFile: string;
begin
  FillChar(SEInfo, SizeOf(SEInfo), 0);
  SEInfo.cbSize := SizeOf(TShellExecuteInfo);
  SEInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  ExecuteFile := PChar('cmd.exe');
  SEInfo.lpFile := PChar(ExecuteFile);
  SEInfo.lpParameters := PChar('/C bin\arc.exe ' + ParamString);
  SEInfo.nShow := SW_SHOWNORMAL;
  if ShellExecuteEx(@SEInfo) then
  begin
    AListBox.Items.Delete(0);
    repeat
      Application.ProcessMessages;
      GetExitCodeProcess(SEInfo.hProcess, ExitCode);
    until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
    Result := true;
  end
  else
    Result := False;
end;

end.
