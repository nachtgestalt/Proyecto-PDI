unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, StdCtrls, Menus, Buttons;

type
  MASCARA=array[0..2,0..2] of integer;
  TForm3 = class(TForm)
    StringGrid1: TStringGrid;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    Kirsch1: TMenuItem;
    Kirch1: TMenuItem;
    Robinson1: TMenuItem;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Kirsch1Click(Sender: TObject);
    procedure Kirch1Click(Sender: TObject);
    procedure Robinson1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
MLAPLACIANO:MASCARA= ((0,-1,0),(-1,4,-1),(0,-1,0));
MROBINSON:MASCARA= ((-1,-2,-1),(0,0,0),(1,2,1));
MKIRSCH:MASCARA= ((-3,-3,-3),(-3,0,-3),(5,5,5));
var
  Form3: TForm3;
  dim : Byte;
  masc:MASCARA;


implementation

{$R *.dfm}


procedure TForm3.FormCreate(Sender: TObject);
begin
  dim:=3;
 StringGrid1.ColCount:=dim;
 StringGrid1.RowCount:=dim;

 TrackBar1.Position:=TrackBar1.Min;
 Label1.Caption:=inttostr(Trackbar1.Position);
end;

procedure TForm3.Kirch1Click(Sender: TObject);
var
i,j: integer;
begin
 for I := 0 to dim-1 do
   begin
     for j := 0 to dim-1  do
     begin
        StringGrid1.Cells[i,j]:=inttostr(MKIRSCH[i,j]);
     end;
   end;
end;

procedure TForm3.Kirsch1Click(Sender: TObject);
var
i,j: integer;
begin
 for I := 0 to dim-1 do
   begin
     for j := 0 to dim-1  do
     begin
        StringGrid1.Cells[i,j]:=inttostr(MLAPLACIANO[i,j]);
     end;
   end;
end;

procedure TForm3.Robinson1Click(Sender: TObject);
var
i,j: integer;
begin
 for I := 0 to dim-1 do
   begin
     for j := 0 to dim-1  do
     begin
        StringGrid1.Cells[i,j]:=inttostr(MROBINSON[i,j]);
     end;
   end;
end;

procedure TForm3.TrackBar1Change(Sender: TObject);
begin
  dim:=TrackBar1.Position;
  label1.Caption:=inttostr(dim);
  StringGrid1.ColCount:=dim;
  StringGrid1.RowCount:=dim;
  StringGrid1.Width:= (StringGrid1.ColCount*StringGrid1.DefaultColWidth)+15;
  StringGrid1.Height:=(StringGrid1.RowCount*StringGrid1.DefaultRowHeight)+15;
end;

end.