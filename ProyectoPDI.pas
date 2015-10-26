unit ProyectoPDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls, Math, JPEG;

type
  Mascara = Array[0..2,0..2] of Integer;
  MATRGB= Array of Array of Array of byte;
  TForm2 = class(TForm)
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    Abrir1: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    Button1: TButton;
    TrackBar1: TTrackBar;
    Binariza: TButton;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox5: TCheckBox;
    Button2: TButton;
    TrackBar2: TTrackBar;
    Label2: TLabel;
    Button3: TButton;
    Edit1: TEdit;
    Button5: TButton;
    Edit2: TEdit;
    GroupBox3: TGroupBox;
    Image2: TImage;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button4: TButton;
    Button10: TButton;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    Bordes1: TMenuItem;
    Punto1: TMenuItem;
    RadioGroup1: TRadioGroup;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    X: TCheckBox;
    Y: TCheckBox;
    Ambas: TCheckBox;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    TrackBar3: TTrackBar;
    RadioGroup2: TRadioGroup;
    Label3: TLabel;
    Button14: TButton;
    procedure Abrir1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BinarizaClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure Punto1Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure btnDerivadaClick(Sender: TObject);
    procedure XClick(Sender: TObject);
    procedure Bordes1Click(Sender: TObject);
    procedure YClick(Sender: TObject);
    procedure AmbasClick(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure Button14Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure copyBM(Alto: Integer; Ancho: Integer; var M: MATRGB; B: TBitmap);         //Procedimiento que copia de bitmap a matriz
    procedure copyMB(Alto:integer; Ancho:Integer; M:MATRGB; var B: Tbitmap);            //Procedimiento que copia de matriz a bitmap
    procedure negativo(var M:MATRGB);                                                   //Procedimiento que aplica filtro negativo
    procedure negativoCanal(var M:MATRGB; c:Integer);
    procedure grises(var M:MATRGB);
    procedure binarizar(var M:MATRGB);
    procedure binarizarPromedio(var M:MATRGB);
    procedure desplazamiento(var M:MATRGB; canal : Integer);
    procedure proporcion(var M:MATRGB; canal : Integer);
    procedure potencia(var M:MATRGB);
    procedure senoidal(var M:MATRGB);
    procedure histograma(var M:MATRGB; c: Integer; t:TImage);
    procedure derivada(var M:MATRGB; direccion: Integer);
    procedure laplaciano;
    procedure gradienteaprox(var M:MATRGB);
  end;

const
Masc : Mascara =( (0,-1,0),
                  (-1,4,-1),
                  (0,-1,0) );
Sobelx : Mascara =( (-1,0,-1),
                  (-2,0,-2),
                  (-1,0,1) );

Sobely : Mascara =( (-1,-2,-1),
                  (0,0,0),
                  (1,2,1) );

var
  Form2: TForm2;
  BM,BMAux             : Tbitmap; //componente para acceso a imagen
  AltoIM, AnchoIM: Integer; //Alto y Ancho de la imagen
  MAT, Mataux,MAThi            : MATRGB;  //Matriz ocupada para guardar el bitmap
  BMJ                  : TJPEGImage;
implementation

//Procedimiento para copiar de bitmap a matriz
procedure TForm2.Button10Click(Sender: TObject);
begin
  grises(MAThi);
  histograma(MAThi,3,Image2);
end;

procedure TForm2.Button12Click(Sender: TObject);
begin
  laplaciano;
end;

procedure TForm2.Button13Click(Sender: TObject);
begin
  case RadioGroup2.ItemIndex of
    0:
      proporcion(MAT,2);
    1:
      proporcion(MAT,1);
    2:
      proporcion(MAT,0);
    3:
      proporcion(MAT,3);
  end;
  copyMB(AltoIM,AnchoIM,MAT,BM);
  image1.Picture.Assign(BM);
end;

procedure TForm2.Button14Click(Sender: TObject);
begin
gradienteaprox(MAT);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  grises(MAT);
  copyMB(AltoIM,AnchoIM,MAT,BM);
  image1.Picture.Assign(BM);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    0:
      desplazamiento(MAT,2);
    1:
      desplazamiento(MAT,1);
    2:
      desplazamiento(MAT,0);
    3:
      desplazamiento(MAT,3);
  end;
  copyMB(AltoIM,AnchoIM,MAT,BM);
  image1.Picture.Assign(BM);
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  potencia(MAT);
  copyMB(AltoIM,AnchoIM,MAT,BM);
  Image1.Picture.Assign(BM);
  Button3.Enabled := False;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  Image1.Picture.Assign(BMAux);
  copyBM(AltoIM,AnchoIM,MAT,BMAux);
  Edit1.Text := '';
  Edit2.Text := '';
  y.Checked := false;
  x.Checked := false;
  ambas.Checked := false;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  senoidal(MAT);
  copyMB(AltoIM,AnchoIM,MAT,BM);
  Image1.Picture.Assign(BM);
  Button5.Enabled := False;
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  Image2.Canvas.FillRect(Image2.Canvas.ClipRect);
end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  histograma(MAT,2,Image2);
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
  histograma(MAT,1,Image2);
end;

procedure TForm2.Button9Click(Sender: TObject);
begin
  histograma(MAT,0,Image2);
end;

//Checkbox para negativo en Azul
procedure TForm2.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    negativoCanal(MAT,0);
    copyMB(AltoIm,AnchoIM,MAT,BM);
    Image1.Picture.Assign(BM);
  end
  else
  begin
    negativoCanal(MAT,0);
    copyMB(AltoIm,AnchoIM,MAT,BM);
    Image1.Picture.Assign(BM);
  end

end;

//Checkbox para negativo en Verde
procedure TForm2.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then
  begin
    negativoCanal(MAT,1);
    copyMB(AltoIm,AnchoIM,MAT,BM);
    Image1.Picture.Assign(BM);
  end
  else
  begin
    negativoCanal(MAT,1);
    copyMB(AltoIm,AnchoIM,MAT,BM);
    Image1.Picture.Assign(BM);
  end
end;

//Checkbox para negativo en Rojo
procedure TForm2.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked then
  begin
    negativoCanal(MAT,2);
    copyMB(AltoIm,AnchoIM,MAT,BM);
    Image1.Picture.Assign(BM);
  end
  else
  begin
    negativoCanal(MAT,2);
    copyMB(AltoIm,AnchoIM,MAT,BM);
    Image1.Picture.Assign(BM);
  end

end;

//Checkbox para negativo por promedio
procedure TForm2.CheckBox5Click(Sender: TObject);
begin
  negativo(MAT);
  copyMB(AltoIm,AnchoIM,MAT,BM);
  //visualizar resultado
  Image1.Picture.Assign(BM);
end;

procedure TForm2.CheckBox7Click(Sender: TObject);
begin
  if CheckBox7.Checked then
  begin
    Binariza.Enabled := true;
    TrackBar1.Enabled := false;
  end
  else
    TrackBar1.Enabled := True;

end;

procedure TForm2.CheckBox8Click(Sender: TObject);
begin

end;

//Boton para aplicar binarizacion
procedure TForm2.AmbasClick(Sender: TObject);
begin
if ambas.Checked then
  begin
    derivada(MAT,3);
  end
end;

procedure TForm2.BinarizaClick(Sender: TObject);
begin
  if CheckBox7.Checked then
  begin
    binarizarPromedio(MAT);
    copyMB(AltoIM,AnchoIM,MAT,BM);
    Image1.Picture.Assign(BM);
  end
  else
  begin
    TrackBar1.Enabled := true;
    binarizar(MAT);
    copyMB(AltoIM,AnchoIM,MAT,BM);
    Image1.Picture.Assign(BM);
  end;
end;

//Procedimiento para copiar de bitmap a matriz
procedure Tform2.copyBM(Alto: Integer; Ancho: Integer; var M: MATRGB; B: TBitmap);
var
i,j,k  :Integer;
P      :Pbytearray;

begin
  for i := 0 to Alto-1  do
    begin
      P := B.ScanLine[i];    //leer i-esima fila de la imagen
      for j := 0 to Ancho - 1 do
        begin
          //leyendo linea completa RGB y asignar a matriz M
          k := 3*j;
          M[i,j,0] := P[k];
          M[i,j,1] := P[k+1];
          M[i,j,2] := P[k+2];
        end // for j
    end  //for i
end;

// Procedimiento para copiar de matriz a bitmap
procedure Tform2.copyMB(Alto: Integer; Ancho: Integer; M: MATRGB; var B: TBitmap);
var
i,j,k  :Integer;
P      :Pbytearray;

begin
  for i := 0 to Alto-1  do
    begin
      P := B.ScanLine[i];    //leer i-esima fila de la imagen
      for j := 0 to Ancho - 1 do
        begin
          //leyendo linea completa RGB y asignar a matriz M
          k := 3*j;
          P[k] := M[i,j,0]; //B
          P[k+1] := M[i,j,1]; //G
          P[k+2] := M[i,j,2];//R
        end; // for j
    end;  //for i
end;

//procedimiento para aplicar negativo
procedure Tform2.negativo(var M: MATRGB);
var
i,j,k:  Integer;

begin
  for I := 0 to AltoIM - 1 do //filas
  begin
      for j := 0 to AnchoIM - 1 do   //columnas
      begin
          for k := 0 to 2 do  //canal
          begin
              M[i,j,k]:= 255-MAT[i,j,k];
          end;
      end;
  end;
end;

//Procedimiento para aplicar negativo dependiendo del canal
procedure Tform2.negativoCanal(var M:MATRGB; c:Integer);
var
i,j,k:  Integer;

begin
  for I := 0 to AltoIM - 1 do //filas
  begin
      for j := 0 to AnchoIM - 1 do   //columnas
      begin
          for k := 0 to 2 do  //canal
          begin
              M[i,j,c]:= 255-MAT[i,j,c];
          end;
      end;
  end;
end;

//Label para mostrar la posicion del trackbar
procedure TForm2.TrackBar1Change(Sender: TObject);
begin
  Label1.Caption := IntToStr(TrackBar1.Position);
  Binariza.Enabled := True;
end;

procedure TForm2.TrackBar2Change(Sender: TObject);
begin
  Label2.Caption := IntToStr(TrackBar2.Position);
  Button2.Enabled := True;
end;

procedure TForm2.TrackBar3Change(Sender: TObject);
begin
  Label3.Caption := IntToStr(TrackBar3.Position);
  Button13.Enabled := True;
end;

procedure TForm2.XClick(Sender: TObject);
begin
if x.Checked then
  begin
    derivada(MAT,1);
  end
end;

procedure TForm2.YClick(Sender: TObject);
begin
if y.Checked then
  begin
    derivada(MAT,2);
  end
end;

//Procedimiento para aplicar grises
procedure Tform2.grises(var M: MATRGB);
var
i,j,k: Integer;

begin
  for I := 0 to AltoIM - 1 do
  begin
    for j := 0 to AnchoIM - 1 do
    begin
      for k := 0 to 2 do
      begin
        M[i,j,0]:=round((M[i,j,0]+ M[i,j,1]+M[i,j,2])/3);
        M[i,j,1]:=round((M[i,j,0]+ M[i,j,1]+M[i,j,2])/3);
        M[i,j,2]:=round((M[i,j,0]+ M[i,j,1]+M[i,j,2])/3);
      end;
    end;
  end;
end;

procedure TForm2.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
ColorIM : Tcolor;
R,G,B   : Byte;

begin

  ///////status bar
  StatusBar1.Panels[1].Text:=Inttostr(X);
  StatusBar1.Panels[2].Text:=Inttostr(Y);
  StatusBar1.Panels[4].Text:=Inttostr(MAT[Y,X,2]);
  StatusBar1.Panels[5].Text:=Inttostr(MAT[Y,X,1]);
  StatusBar1.Panels[6].Text:=Inttostr(MAT[Y,X,0]);

end;


//Creacion del bitmap al cargar el programa
procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BM.Free;
  BMAux.Free;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  BM := TBitmap.Create;
  BMJ := TJPEGImage.Create;
  BMAux := TBitmap.Create;
end;

//Procedimiento para binarizar
procedure TForm2.binarizar(var M: MATRGB);
var
PBprom,PB,i,j,prom  : Integer;
begin
  PB := TrackBar1.Position;     //valor del punto o umbral de binarizacion
  grises(M);       //convierte a grises

  //Sacar punto de binarizacion promedio
  for I := 0 to AltoIM - 1 do
  begin
    for j := 0 to AnchoIM - 1 do
    begin
      prom := M[i,j,0];
    end;
  end;

  PBprom := round(prom/(AltoIM*AnchoIM));

  for I := 0 to AltoIM - 1 do
  begin
    for j := 0 to AnchoIM - 1 do
    begin
      if M[i,j,0]<PB then
      begin
        M[i,j,0]:=0;
        M[i,j,1]:=0;
        M[i,j,2]:=0;
      end
      else
      begin
        M[i,j,0]:=255;
        M[i,j,1]:=255;
        M[i,j,2]:=255;
      end;
    end;
  end;
end;

procedure TForm2.binarizarPromedio(var M: MATRGB);
var
PBprom,PB,i,j,prom  : Integer;
begin
  PB := TrackBar1.Position;     //valor del punto o umbral de binarizacion
  grises(M);       //convierte a grises

  //Sacar punto de binarizacion promedio
  for I := 0 to AltoIM - 1 do
  begin
    for j := 0 to AnchoIM - 1 do
    begin
      prom := prom + M[i,j,0];
    end;
  end;

  PBprom := round(prom/(AltoIM*AnchoIM));

  for I := 0 to AltoIM - 1 do
  begin
    for j := 0 to AnchoIM - 1 do
    begin
      if M[i,j,0]<PBprom then
      begin
        M[i,j,0]:=0;
        M[i,j,1]:=0;
        M[i,j,2]:=0;
      end
      else
      begin
        M[i,j,0]:=255;
        M[i,j,1]:=255;
        M[i,j,2]:=255;
      end;
    end;
  end;
end;



procedure TForm2.Bordes1Click(Sender: TObject);
begin
if Bordes1.Checked = false then
  begin
    GroupBox4.Enabled := True;
    GroupBox4.Visible := True;
    GroupBox3.Enabled := True;
    GroupBox3.Visible := True;
    Bordes1.Checked := true;
  end
  else
  begin
    GroupBox4.Enabled := False;
    GroupBox4.Visible := False;
    GroupBox3.Enabled := False;
    GroupBox3.Visible := False;
    Bordes1.Checked := false;
  end;
end;

procedure TForm2.btnDerivadaClick(Sender: TObject);
begin

end;

//Procedimiento para desplazar
procedure Tform2.desplazamiento(var M: MATRGB; canal: Integer);
var
  i,j,k,delta,desp: Integer;
  porc : real;
begin
  delta := TrackBar2.Position;
  porc := TrackBar2.Position *(1/100);
  for i := 0 to AltoIM - 1 do
  begin
    for j := 0 to AnchoIM - 1 do
    begin
      if canal = 3 then
      begin
      for k := 0 to 2 do
      begin
        desp := mat[i,j,k] + delta;
        if desp > 255 then
          desp := 255;
        MAT[i,j,k] := desp;
      end;
      end
      else
      begin
        desp := mat[i,j,canal] + delta;
        if desp > 255 then
          desp := 255;
        M[i,j,canal] := desp;
      end;
    end;
  end;
end;

//Procedimiento para filtro proporcion
procedure Tform2.proporcion(var M: MATRGB; canal: Integer);
var
  i,j,k,proporcion,desp: Integer;
  porc : real;
begin
  porc := TrackBar3.Position*(1/100);
  for i := 0 to AltoIM - 1 do
  begin
    for j := 0 to AnchoIM - 1 do
    begin
      if canal = 3 then
      begin
      for k := 0 to 2 do
      begin
        proporcion := round(m[i,j,k] + porc*m[i,j,k]);
        if proporcion > 255 then
          proporcion := 255;
        MAT[i,j,k] := proporcion;
      end;
      end
      else
      begin
        proporcion := round(m[i,j,canal] + porc*m[i,j,canal]);
        if proporcion > 255 then
          proporcion := 255;
        M[i,j,canal] := proporcion;
      end;
    end;
  end;
end;


procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  Button3.Enabled := true;
end;

procedure TForm2.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  Button5.Enabled := True;
end;

//Procedimiento filtro potencia
procedure TForm2.potencia(var M: MATRGB);
var
  i,j,k: Integer;
  exponente: Real;
begin
  exponente := StrToFloat(Edit1.Text);
  if exponente <=0 then
  begin
    Application.MessageBox(pchar('El valor debe ser mayor a 0'),
      pchar('Error'), (MB_OK + MB_ICONSTOP));
    Edit1.Clear;
  end
  else
  begin
    for i := 0 to AltoIM - 1 do
    begin
      for j := 0 to AnchoIM - 1 do
      begin
        for k := 0 to 2 do
        begin
          M[i,j,k] := round(power((MAT[i,j,k]/256),exponente)*256);
        end;
      end;
    end;
  end;
end;

procedure TForm2.Punto1Click(Sender: TObject);
begin
  if Punto1.Checked = false then
  begin
    GroupBox1.Enabled := True;
    GroupBox1.Visible := True;
    GroupBox3.Enabled := True;
    GroupBox3.Visible := True;
    Punto1.Checked := true;
  end
  else
  begin
    GroupBox1.Enabled := False;
    GroupBox1.Visible := False;
    GroupBox3.Enabled := False;
    GroupBox3.Visible := False;
    Punto1.Checked := false;
  end;
end;

//Procedimiento filtro senoidal
procedure TForm2.senoidal(var M: MATRGB);
var
  i,j,k,result: Integer;
  alpha: Real;
begin
  alpha := StrToFloat(Edit2.Text);
  {if alpha <=0 then
  begin
    Application.MessageBox(pchar('El valor debe ser mayor a 0'),
      pchar('Error'), (MB_OK + MB_ICONSTOP));
    Edit1.Clear;
  end
  else
  begin}
    for i := 0 to AltoIM - 1 do
    begin
      for j := 0 to AnchoIM - 1 do
      begin
        for k := 0 to 2 do
        begin
          result := Round(alpha*sin((2*pi)*(MAT[i,j,k]/255)));
          M[i,j,k] := M[i,j,k]-result;
        end;
      end;
    end;
  //end;
end;

procedure Tform2.histograma(var M: MATRGB; c: Integer; t:TImage);
var
  HG        : array[0..255] of Integer; //Calcular la frecuencia
  i,j       : Integer;
  MAXG,result,yr      : Integer;
  logaritmo:  array[0..255] of real;

begin
  //Inicializar el vector
  for I := 0 to 255 do
  begin
    HG[i] := 0;
  end;
  if c = 3 then
  begin
    for I := 0 to AltoIM - 1 do
    begin
      for j := 0 to AnchoIM - 1 do
      begin
         inc(HG[M[i,j,1]]);
      end;
    end;
  end

  else
  begin
    for I := 0 to AltoIM - 1 do
      begin
        for j := 0 to AnchoIM - 1 do
        begin
         inc(HG[M[i,j,c]]);
        end;
      end;
  end;


    //Calcular el valor maximo
    MAXG := HG[0];
    for i := 1 to 255 do
      begin
        if HG[i] > MAXG then
        begin
          MAXG := HG[i]
        end;
      end;

      if c = 2 then t.canvas.pen.color := clRed;
      if c = 1 then t.canvas.pen.color := clGreen;
      if c = 0 then t.canvas.pen.color := clBlue;
      if c = 3 then t.Canvas.Pen.Color := clBlack;


      yr := round( ((t.height-1) * (1- HG[0]/MAXG)));
      t.Canvas.MoveTo(0,yr);

      for I := 1 to 255 do
      begin
        if  CheckBox6.Checked then
        begin
          //logaritmo[i] := Log10(HG[i]);
          //yr := round((Ln( ((t.height-1) * (1 - HG[i]/MAXG))+ 1 )/Ln(MAXG))*256);
          yr := round((t.height-1) * (1 - (Ln(HG[i]+1)/Ln(MAXG))));
          t.Canvas.LineTo(i,yr);
        end
        else
        begin
          yr := round(((t.height-1) * ((1- HG[i]/MAXG))));
          t.Canvas.LineTo(i,yr);
        end;
      end;
end;

procedure TForm2.derivada(var M: MATRGB; direccion: Integer);
var
i,j,k : Integer;
begin
  if(direccion = 1) then // Derivada con respecto a X
  begin
    for I := 0 to AltoIM - 1 do
    begin
      for j := 0 to AnchoIM - 2 do
      begin
        for k := 0 to 2 do
        begin
          M[i,j,k] := Abs(M[i,j+1,k] - M[i,j,k])
        end;//k
      end;//j
    end;//i
  end;

  if(direccion = 2) then // Derivada con respecto a Y
  begin
    for I := 0 to AltoIM - 2 do
    begin
      for j := 0 to AnchoIM - 1 do
      begin
        for k := 0 to 2 do
        begin
          M[i,j,k] := Abs(M[i+1,j,k] - M[i,j,k])
        end;//k
      end;//j
    end;//i
  end;

  if(direccion = 3) then // Derivada en ambas direcciones
  begin
    for I := 0 to AltoIM - 2 do
    begin
      for j := 0 to AnchoIM - 2 do
      begin
        for k := 0 to 2 do
        begin
          M[i,j,k] := (Abs(M[i+1,j,k] - M[i,j,k]) + Abs(M[i,j+1,k] - M[i,j,k])) div 2;
        end;//k
      end;//j
    end;//i
  end;
  binarizarPromedio(M);
  copyMB(AltoIM, AnchoIM, M, BM);
  Image1.Picture.Assign(BM);
end;

//Procedimiento para aplicar laplaciano
procedure TForm2.laplaciano;
var
i,j,k,a,b,conv  : Integer;
AUX           : MATRGB;
begin
  SetLength(Aux,AltoIM,AnchoIM,3);
  for i := 1 to AltoIM - 2 do
  begin
    for j := 1 to AnchoIM-2 do
    begin
      for k := 0 to 2 do
      begin
      conv := 0;
        for a := -1 to 1 do
        begin
          for b := -1 to 1 do
          begin
            conv := conv + (masc[a+1,b+1] * MAT[i+a,j+b,k]);
          end;//b
        end;//a
        AUX[i,j,k] := abs(conv) div 4;
      end;//k
    end;//j
  end;//i
  binarizarPromedio(AUX);
  copyMB(AltoIM,AnchoIM,AUX,BM);
  Image1.Picture.Assign(BM);
end;

//Procedimiento para aplicar gradiente aproximado
procedure TForm2.gradienteaprox(var M: MATRGB);
var
i,j,k,a,b,conv  : Integer;
begin
for I := 0 to AltoIM - 2 do
begin
  for j := 0 to AnchoIM - 2 do
  begin
    for k := 0 to 2 do
    begin
      M[i,j,k] := round(sqrt(Power((M[i+1,j+1,k] - M[i,j,k]),2) + Power((M[i,j+1,k] - M[i+1,j,k]),2)));
    end;//k
  end;//j
end;//i
binarizarPromedio(M);
copyMB(AltoIM, AnchoIM, M, BM);
Image1.Picture.Assign(BM);

end;

{$R *.dfm}


procedure TForm2.Abrir1Click(Sender: TObject);
var
extension : string;
begin
    if  OpenPictureDialog1.Execute then
    begin
      ScrollBox1.Enabled := True;         //Se activa el cuadro contenedor del TImage
      Label1.Caption := IntToStr(TrackBar1.Position);  //Se asigna al label la posicion del trackbar de binarizacion
      Label2.Caption := IntToStr(TrackBar2.Position);  //Se asigna al label la posicion del trackbar de proporcion
      Label3.Caption := IntToStr(TrackBar3.Position);
      Edit1.Text := ''; //Se ponen en blanco los edit
      Edit2.Text := '';
      //Asociar una imagen al Bitmap
      extension := ExtractFileExt(OpenPictureDialog1.FileName); // Se extrae la extension de la imagen
      if (UpperCase(extension) = '.JPG') or (UpperCase(extension) = '.JPEG') then //Verificamos que la extension sea JPG
      begin
        BMJ.LoadFromFile(OpenPictureDialog1.FileName); //Asociamos la imagen al JPEGImage
        BM.Assign(BMJ); //Asignamos el JPEGImage al bitmap
        BMAux.Assign(BMJ); //Asignamos el JPEGImage al bitmap auxiliar
      end;

      if UpperCase(extension) = '.BMP' then //Verificamos que la extension sea BMP
      begin
        BM.LoadFromFile(OpenPictureDialog1.FileName);
        BMAux.LoadFromFile(OpenPictureDialog1.FileName);
        if BM.PixelFormat <> pf24bit then
        begin
          Bm.PixelFormat := pf24bit;
          BMAux.PixelFormat := pf24bit;
        end;
      end;

      AltoIM := BM.Height;
      AnchoIM := BM.Width;

      StatusBar1.Panels[7].Text := IntToStr(AltoIM) + 'x' + IntToStr(AnchoIM);

      //Crear arreglo 3D
      SetLength(Mat,AltoIM,AnchoIM,3);
      SetLength(Mataux,AltoIM,AnchoIM,3);
      SetLength(Mathi,AltoIM,AnchoIM,3);

      Image1.Picture.Assign(BM);

      copyBM(AltoIM,AnchoIM,MAT,BM);
      copyBM(AltoIM,AnchoIM,Mataux,BM);
      copyBM(AltoIM,AnchoIM,Mathi,BM);
    end;
end;

end.
