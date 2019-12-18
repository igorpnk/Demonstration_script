
Procedure LogShow();
begin
  if b_Log.Caption = ' \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/ ' then
  begin
    b_Log.Caption := ' /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\ ';
    Form1.Height := 540;
  end
  else
  begin
    b_Log.Caption := ' \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/ ';
    Form1.Height := 355;
  end;
end;

procedure TForm1.b_LogClick(Sender: TObject);
begin
  LogShow();
end;

Function XMLGetAttrValue (InputStr : String; AttrName : String) : String;
Var
i      : integer;
WriteS : bolean;
s      : String;
ResultS: String;
Begin
 WriteS := false;
 ResultS:= '';
 if pos(AttrName,InputStr) >0 then
 For i := pos(AttrName,InputStr)+length(AttrName) to length(InputStr) do
 begin
   s := InputStr[i];
   if writeS then
   begin
     if (InputStr[i] = '"' |InputStr[i] = '''' ) then break;
     Results := Results + InputStr[i];
   end;
   if (InputStr[i] = '"' |InputStr[i] = '''' )  then WriteS := true;
 end;
 Result := ResultS;
end;


Procedure StartScript ();
var
  Board       : IPCB_Board;
  DataFile    : TStringList;
  IndexFile   : TStringList;
  str         : String;
Begin
     DataFile := TStringList.Create;                     //Файл данных
     Board := PCBServer.GetCurrentPCBBoard;              // Получение Текущей платы
     If Board = nil then Begin ShowError('Open board!'); Exit; End; // Если платы нет то выходим
     if FileExists(Board.FileName+'.sdem') then begin    //если файл данных существует, то загружаем его
     DataFile.LoadFromFile(Board.FileName+'.sdem');
     end else begin
         DataFile.DefaultEncoding := TEncoding.UTF8;
         DataFile.Add('Number="0"' +' ' +'X1="100"' +' '+ 'Y1="100"'+' ' +'X2="200"' +' '+ 'Y2="200"');
         DataFile.SaveToFile(Board.FileName+'.sdem');
         //DataFile.Free;
         //DataFile.LoadFromFile(Board.FileName+'.sdem');
     end;

     IndexFile := TStringList.Create;                     //Файл позиции
     if FileExists(Board.FileName+'.sdemi') then begin    //если файл позиции существует, то загружаем его
     IndexFile.LoadFromFile(Board.FileName+'.sdemi');
     end else begin
         IndexFile.Add('0');
         IndexFile.SaveToFile(Board.FileName+'.sdemi');
         IndexFile.Free;
     end;

     str := DataFile.Get(0);
     lbCount.Caption := DataFile.Count;
     lbNumberStep.Text := XMLGetAttrValue(str,'Number');
     lbX1.Text := XMLGetAttrValue(str,'X1');
     lbX2.Text := XMLGetAttrValue(str,'X2');
     lbY1.Text := XMLGetAttrValue(str,'Y1');
     lbY2.Text := XMLGetAttrValue(str,'Y2');
     Form1.Show;
     DataFile.Free;
end;

procedure GoPosition();
var
Board       : IPCB_Board;
Track1      : IPCB_Track;
Track2      : IPCB_Track;
begin
     Board := PCBServer.GetCurrentPCBBoard;              // Получение Текущей платы
     Track1 :=  PCBServer.PCBObjectFactory(eTrackObject, eNoDimension, eCreate_Default);
     Track1.Layer := eMechanical12;
     Track1.x1 := MMsToCoord(lbX1.Text)+Board.XOrigin;
     Track1.y1 := MMsToCoord(lbY1.Text)+Board.YOrigin;
     Track1.x2 := MMsToCoord(lbX2.Text)+Board.XOrigin;
     Track1.y2 := MMsToCoord(lbY2.Text)+Board.YOrigin;
     Track1.Width := MMsToCoord(0.01);
     Track1.Selected := True;
     Board.AddPCBObject(Track1);
     Track1.Selected := True;
     Client.SendMessage('PCB:Zoom', 'Action=Selected' , 255, Client.CurrentView);
     Board.RemovePCBObject(Track1);
     //ShowError('123');
end;

procedure GoPositionOffline(X1:string, Y1:string, X2:string, Y2:string);
var
Board       : IPCB_Board;
Track1      : IPCB_Track;
Track2      : IPCB_Track;
begin
     Board := PCBServer.GetCurrentPCBBoard;              // Получение Текущей платы
     Track1 :=  PCBServer.PCBObjectFactory(eTrackObject, eNoDimension, eCreate_Default);
     Track1.Layer := eMechanical12;
     Track1.x1 := MMsToCoord(X1)+Board.XOrigin;
     Track1.y1 := MMsToCoord(Y1)+Board.YOrigin;
     Track1.x2 := MMsToCoord(X2)+Board.XOrigin;
     Track1.y2 := MMsToCoord(Y2)+Board.YOrigin;
     Track1.Width := MMsToCoord(0.01);
     Track1.Selected := True;
     Board.AddPCBObject(Track1);
     Track1.Selected := True;
     Client.SendMessage('PCB:Zoom', 'Action=Selected' , 255, Client.CurrentView);
     Board.RemovePCBObject(Track1);
     //ShowError('123');
end;

procedure TForm1.Stage1Click(Sender: TObject);

begin
GoPosition()
     //ShowError('123');
end;


procedure TForm1.btSetClick(Sender: TObject);
var
  Board       : IPCB_Board;
  DataFile    : TStringList;
  str         : String;
begin
     DataFile := TStringList.Create;                     //Файл данных
     Board := PCBServer.GetCurrentPCBBoard;              // Получение Текущей платы
     DataFile.LoadFromFile(Board.FileName+'.sdem');
     //DataFile.Insert(0,'213');
     DataFile.Insert(lbNumberStep.Text, 'Number="' + lbNumberStep.Text +'"' +' '
                                        +'X1="'+lbX1.Text+'"' +' '
                                        +'Y1="'+lbY1.Text+'"'+' '
                                        +'X2="'+lbX2.Text+'"' +' '
                                        +'Y2="'+lbY2.Text+'"');
     DataFile.Delete(lbNumberStep.Text + 1);
     DataFile.SaveToFile(Board.FileName+'.sdem');
     DataFile.Free;
end;

procedure GoLeft();
var
  Board       : IPCB_Board;
  DataFile    : TStringList;
  IndexFile   : TStringList;
  str         : String;
  indexstr    : String;
begin
     DataFile := TStringList.Create;                     //Файл данных
     IndexFile := TStringList.Create;                     //Файл индекса
     Board := PCBServer.GetCurrentPCBBoard;              // Получение Текущей платы
     DataFile.LoadFromFile(Board.FileName+'.sdem');
     IndexFile.LoadFromFile(Board.FileName+'.sdemi');
     indexstr:= IndexFile.Get(0);
     IndexFile.Free;
     IndexFile := TStringList.Create;
     //DataFile.Insert(0,'213');
     if (indexstr > '0') then
     begin
       indexstr := indexstr -1;
       str := DataFile.Get(StrToInt(indexstr));
       DataFile.Free;
       GoPositionOffline(XMLGetAttrValue(str,'X1'),
       XMLGetAttrValue(str,'Y1'),
       XMLGetAttrValue(str,'X2'),
       XMLGetAttrValue(str,'Y2'));
       IndexFile.Add(indexstr);
       IndexFile.SaveToFile(Board.FileName+'.sdemi');
       IndexFile.Free;
     end else begin
     ShowMessage('вы достигли нулевой позиции');
     end;
end;

procedure TForm1.btleftClick(Sender: TObject);
var
  Board       : IPCB_Board;
  DataFile    : TStringList;
  IndexFile   : TStringList;
  str         : String;
begin
     DataFile := TStringList.Create;                     //Файл данных
     IndexFile := TStringList.Create;                     //Файл индекса
     Board := PCBServer.GetCurrentPCBBoard;              // Получение Текущей платы
     DataFile.LoadFromFile(Board.FileName+'.sdem');
     //DataFile.Insert(0,'213');
     if (lbNumberStep.Text > '0') then
     begin
       lbNumberStep.Text := lbNumberStep.Text -1;
       str := DataFile.Get(lbNumberStep.Text);
       DataFile.Free;
       lbX1.Text := XMLGetAttrValue(str,'X1');
       lbX2.Text := XMLGetAttrValue(str,'X2');
       lbY1.Text := XMLGetAttrValue(str,'Y1');
       lbY2.Text := XMLGetAttrValue(str,'Y2');

       IndexFile.Add(lbNumberStep.Text);
       IndexFile.SaveToFile(Board.FileName+'.sdemi');
       IndexFile.Free;

       GoPosition();

     end else begin
     ShowMessage('вы достигли нулевой позиции');
     end;
end;

procedure GoRight();
var
  Board       : IPCB_Board;
  DataFile    : TStringList;
  IndexFile   : TStringList;
  str         : String;
  indexstr       : String;
begin
     DataFile := TStringList.Create;                     //Файл данных
     IndexFile := TStringList.Create;                     //Файл индекса
     Board := PCBServer.GetCurrentPCBBoard;              // Получение Текущей платы
     DataFile.LoadFromFile(Board.FileName+'.sdem');
     IndexFile.LoadFromFile(Board.FileName+'.sdemi');
     indexstr:= IndexFile.Get(0);
     IndexFile.Free;
     IndexFile := TStringList.Create;
     //DataFile.Insert(0,'213');
     if (indexstr < DataFile.Count-1) then
     begin
       indexstr := indexstr +1;
       str := DataFile.Get(StrToInt(indexstr));
       DataFile.Free;
       GoPositionOffline(XMLGetAttrValue(str,'X1'),
       XMLGetAttrValue(str,'Y1'),
       XMLGetAttrValue(str,'X2'),
       XMLGetAttrValue(str,'Y2'));
       IndexFile.Add(indexstr);
       IndexFile.SaveToFile(Board.FileName+'.sdemi');
       IndexFile.Free;
     end else begin
     ShowMessage('вы достигли позиции = ' + IntToStr(DataFile.Count-1) );
     end;
end;


procedure TForm1.btRightClick(Sender: TObject);
var
  Board       : IPCB_Board;
  DataFile    : TStringList;
  IndexFile   : TStringList;
  str         : String;
begin
     DataFile := TStringList.Create;                     //Файл данных
     IndexFile := TStringList.Create;                     //Файл индекса
     Board := PCBServer.GetCurrentPCBBoard;              // Получение Текущей платы
     DataFile.LoadFromFile(Board.FileName+'.sdem');
     //DataFile.Insert(0,'213');
     if (lbNumberStep.Text < DataFile.Count-1) then
     begin
       lbNumberStep.Text := lbNumberStep.Text +1;
       str := DataFile.Get(lbNumberStep.Text);
       DataFile.Free;
       lbX1.Text := XMLGetAttrValue(str,'X1');
       lbX2.Text := XMLGetAttrValue(str,'X2');
       lbY1.Text := XMLGetAttrValue(str,'Y1');
       lbY2.Text := XMLGetAttrValue(str,'Y2');

       IndexFile.Add(lbNumberStep.Text);
       IndexFile.SaveToFile(Board.FileName+'.sdemi');
       IndexFile.Free;

       GoPosition();
       //Stage1Click();
     end else begin
     ShowMessage('вы достигли позиции = ' + IntToStr(DataFile.Count-1) );
     end;
end;


procedure TForm1.btADDClick(Sender: TObject);
var
  Board       : IPCB_Board;
  DataFile    : TStringList;
  str         : String;
begin
     DataFile := TStringList.Create;                     //Файл данных
     Board := PCBServer.GetCurrentPCBBoard;              // Получение Текущей платы
     DataFile.LoadFromFile(Board.FileName+'.sdem');
     //DataFile.Insert(0,'213');
     DataFile.Add('Number="' + IntToStr(DataFile.Count)+'"' +' '
                                        +'X1="'+lbX1.Text+'"' +' '
                                        +'Y1="'+lbY1.Text+'"'+' '
                                        +'X2="'+lbX2.Text+'"' +' '
                                        +'Y2="'+lbY2.Text+'"');
     DataFile.SaveToFile(Board.FileName+'.sdem');
     lbCount.Caption := DataFile.Count;
     DataFile.Free;
end;

