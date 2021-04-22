 // Глобальная переменная, содержащая id заказчика при выдаче задания
var
  CustomerTask: integer;

 // Глобальная переменная, содержащая id задания (требуется для формирования отчета)
var
  TaskID: integer;


procedure ResizeColumn();
begin
     //frm_Main.tg_Task_List.BestFitColumns(bfBoth);
     frm_Main.tg_Task_List.Columns[0].Alignment:= tacenter;
     frm_Main.tg_Task_List.Columns[0].Width:=80;//................ № задания
     frm_Main.tg_Task_List.Columns[1].Width:= 100; //..............Дата
     frm_Main.tg_Task_List.Columns[2].Width:= 150; //..............Заказчик
     frm_Main.tg_Task_List.Columns[3].Width:= 300; //..............Исполнители
     frm_Main.tg_Task_List.Columns[4].Width:= 100; //..............Статус
     frm_Main.tg_Task_List.Columns[5].Width:= 580; //..............Примечание
end;

// start ================================== frm_Task ============================= start

procedure frm_Task_OnClose (Sender: TObject; Action: string);
begin
   ResizeColumn();
end;
                                                                                                              
 // ...........................................................................Получение id задания для формирования отчета
procedure frm_Main_tg_Task_List_OnDoubleClick (Sender: TObject);
begin
  TaskID:= frm_Main.tg_Task_List.dbItemID;
  frm_Task.txt_TaskID.Text:= IntToStr(TaskID);
end;

 // ...........................................................................Запись новых постеров в примечание (при нажатии кнопки)
procedure frm_Task_Button1_OnClick (Sender: TObject; var Cancel: boolean);
begin
  frm_Task.memo_Task.Text:= frm_Task.tg_Adres_in_Task.Cells[5,0];
end;

 // ...........................................................................Копирование исполнителей в задание
procedure frm_Task_OnSave (Sender: TObject; var Cancel: boolean);
var
a, b, c, d, e, f: string;
row_count: integer;
begin
  row_count:= frm_Task.tg_Workers.RowCount;
  if row_count = 1 then
  begin
     a:= frm_Task.tg_Workers.Cells[0,0];
     b:= frm_Task.tg_Workers.Cells[1,0];
     frm_Task.txt_WorkersInTask.Text:= a + ' ' + b;
  end
  else if row_count = 2 then
  begin
     a:= frm_Task.tg_Workers.Cells[0,0];
     b:= frm_Task.tg_Workers.Cells[1,0];
     c:= frm_Task.tg_Workers.Cells[0,1];
     d:= frm_Task.tg_Workers.Cells[1,1];
     frm_Task.txt_WorkersInTask.Text:= a + ' ' + b + ', ' + c + ' ' + d;
  end
  else if row_count = 3 then
  begin
    a:= frm_Task.tg_Workers.Cells[0,0];
    b:= frm_Task.tg_Workers.Cells[1,0];
    c:= frm_Task.tg_Workers.Cells[0,1];
    d:= frm_Task.tg_Workers.Cells[1,1];
    e:= frm_Task.tg_Workers.Cells[0,2];
    f:= frm_Task.tg_Workers.Cells[1,2];
    frm_Task.txt_WorkersInTask.Text:= a + ' ' + b + ', ' + c + ' ' + d + ' ' + e + ' ' + f;
  end
  else
   begin
   end;
end;

 // ...........................................................................Окраска строки при выполнении задания
procedure frm_Task_tg_Adres_in_Task_OnChange (Sender: TObject);
var
i, Ii, cR, cC,k, l: integer;
sID: string;
begin
 cR := frm_Task.tg_Adres_in_Task.RowCount - 1;
 cC := frm_Task.tg_Adres_in_Task.Columns.Count -1;
 frm_Task.tg_Adres_in_Task.BeginUpdate;
 for i := 0 to cR do
   begin
      if (frm_Task.tg_Adres_in_Task.Cells[7,i]) = 'Да'  then
        begin
          for Ii:=0 to Cc do frm_Task.tg_Adres_in_Task.Cell[Ii,i].Color := $00CEEFB8;
        end;
end;
end;

// ............................................................................Модуль проверки наличия id заказчика в переменной "CustomerTask", если значение <=0- блокировка кнопки добавления заданий, иначе - кнопка доступна.
procedure CheckButton();
begin
        CustomerTask:= frm_Task.cb_Customer_F_Task.ItemIndex ;
    if CustomerTask <= 0 then
        begin
          frm_Task.btn_Add_Task_Adres.Enabled:= False;
          frm_Task.btn_Add_Worker.Enabled:= False;
        end
     else
        begin
          frm_Task.btn_Add_Task_Adres.Enabled:= True;
          frm_Task.btn_Add_Worker.Enabled:= True;
        end;
end;

// ...........................................................................Заполнение переменной "CustomerTask" при выборе заказчика в комбобоксе при выдаче задания.
procedure frm_Task_cb_Customer_F_Task_OnChange (Sender: TObject);
var
TempCustomerTask : integer;
begin
    TempCustomerTask:= frm_Task.cb_Customer_F_Task.ItemIndex;
    CheckButton();
    FilterForAdres(TempCustomerTask);

end;

// ...........................................................................Проверка id заказчика при загрузке формы.
procedure frm_Task_OnShow (Sender: TObject; Action: string);
var
TempCustomerTask : integer;
begin
     TempCustomerTask:= frm_Task.cb_Customer_F_Task.ItemIndex ;
     CheckButton();
     frm_Task.txt_TaskID.Text:= IntToStr(TaskID);
     FilterForAdres(TempCustomerTask);

end;

// ...........................................................................Модуль подсчета исполнителей при выдаче задания
procedure CalculateIspol (Sender: string);
var
    Ispol: integer;
begin
    Ispol := frm_Task.tg_Workers.RowCount;
    frm_Task.editNumOfWorkers.Text := FloatToStr(Ispol);
end;

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




// ================================== frm_Main ===========================================

 // ...........................................................................Просмотр фото РК при выборе адреса РК
procedure frm_Main_tg_Adres_List_OnCellClick (Sender: TObject; ACol, ARow: Integer);
begin
    frm_Main.db_imgPhotoRK.Clear;
    //frm_Main.db_imgPhotoRK.LoadFromDatabase('t_Adres', 'photo', frm_Main.tg_Adres_List.dbItemID);
end;

//............................................................................Обновление записей после закрытия формы или нажатия кнопки "Фильтр" "frm_Task_Adres"c применением фильтра
procedure frm_Main_btnFilter_OnClick (Sender: TObject; var Cancel: boolean);
begin
    ResizeColumn();
end;


// ...........................................................................Загрузка значений по умолчанию для компонентов выбора даты
procedure frm_Main_OnShow (Sender: TObject; Action: string);
begin
   frm_Main.dateEndTasks.DateTime:= now;
   frm_Main.dateStartTasks.DateTime:= now - 31;
   frm_Main.tg_Task_List.BestFitColumns(bfBoth);
   ResizeColumn();
   frm_Main.btnFilter.Click;
end;


 // ...........................................................................Отображение исполнителей при выборе задания на главной странице
procedure frm_Main_tg_Task_List_OnCellClick (Sender: TObject; ACol, ARow: Integer);
begin
    frm_Main.tg_WorkersTask.dbFilter := 'id_t_Task=' + IntToStr(frm_Main.tg_Task_List.dbItemID);
    frm_Main.tg_WorkersTask.dbUpdate;
    frm_Main.tg_Adres_in_Task.BestFitColumns(bfBoth);
end;

 // ...........................................................................Окраска строки при выполнении задания (на главной форме)
procedure frm_Main__tg_Adres_in_Task__OnChange (Sender: TObject);
var
i, Ii, cR, cC,k, l: integer;
sID: string;
begin                           
 cR := frm_Main.tg_Adres_in_Task.RowCount - 1;
 cC := frm_Main.tg_Adres_in_Task.Columns.Count -1;
 frm_Main.tg_Adres_in_Task.BeginUpdate;
 for i := 0 to cR do
   begin
      if (frm_Main.tg_Adres_in_Task.Cells[7,i]) = 'Да'  then
        begin
          for Ii:=0 to Cc do frm_Main.tg_Adres_in_Task.Cell[Ii,i].Color := $00CEEFB8;
        end;
end;
end;

//.............................................................................Отчет "Поклейка"
procedure frm_Main_Button11_OnClick (Sender: TObject; var Cancel: boolean);
var
    date_start, date_end, chbox_complited : string;
    id_customer : integer;
    i, Ii, cR, cC,k, l: integer;
    sID: string;
begin

    date_start:= frm_Main.dateStartReport.sqlDate ;
    date_end:= frm_Main.dateEndReport.sqlDate ;
    id_customer:= frm_Main.cbCustomerReport.dbItemID;
    chbox_complited:= frm_Main.chbOnlyInWork.sqlValue;

    if ((date_start = 'NULL') OR (date_end = 'NULL'))
        then ShowMessage('Выберите даты начала и окончания периода!')
    else
       begin
          frm_Main.tg_Report.dbSQL:= ' SELECT ' +
        ' t_Task.id AS `№ Задания`, ' +
        ' DATE_FORMAT( t_Task.date, "%d.%m.%Y" ) AS `Дата задания`, ' +
        ' t_Customer.customer_name AS `Заказчик`, ' +
        ' t_Adres.adres AS `Адрес`, ' +
        ' t_Format.format_name AS `Формат`, ' +
        ' t_Place.place_name AS `Сторона`, ' +
        ' t_Adres_Task.old_poster AS `Старый постер`, ' +
        ' t_Adres_Task.new_poster AS `Новый постер`, ' +
        ' DATE_FORMAT( t_Adres_Task.date, "%d.%m.%Y" ) AS `Выдано на`, ' +
        ' t_Work.work_name AS `Работы`, ' +
        ' t_Task.workers_in_task AS `Исполнители`, ' +
        ' (CASE t_Adres_Task.task_status WHEN 1 THEN "Выполнено" WHEN 0 THEN "В работе" END) AS "Статус", ' +
        ' t_Adres_Task.note AS "Примечание" ' +
        ' FROM t_Task ' +
        ' INNER JOIN t_Adres_Task ON t_Task.id = t_Adres_Task.id_t_Task ' +
        ' INNER JOIN t_Adres ON t_Adres_Task.id_t_Adres = t_Adres.id ' +
        ' INNER JOIN t_Format ON t_Adres.id_t_Format = t_Format.id ' +
        ' AND t_Adres_Task.id_t_Format = t_Format.id ' +
        ' INNER JOIN t_Place ON t_Adres_Task.id_t_Place = t_Place.id ' +
        ' INNER JOIN t_Work ON t_Adres_Task.id_t_Work = t_Work.id ' +
        ' INNER JOIN t_Customer ON t_Adres.id_t_Customer = t_Customer.id ' +
        ' WHERE t_Adres_Task.date BETWEEN ' + date_start + 'AND' + date_end +
        ' AND (CASE WHEN ' + IntToStr(id_customer) +  '<> -1 THEN t_Task.id_t_Customer = ' + IntToStr(id_customer) + ' ELSE 1=1 END) ' +
        ' AND (CASE WHEN ' + chbox_complited +  '= 1 THEN t_Adres_Task.task_status = 0 ELSE t_Adres_Task.task_status = 0 OR 1 END) ';
        frm_Main.tg_Report.dbSQLExecute;
         // ................................................................Окраска строки при выполнении задания (в отчете о поклейке)
         cR := frm_Main.tg_Report.RowCount - 1;
         cC := frm_Main.tg_Report.Columns.Count -1;
         frm_Main.tg_Report.BeginUpdate;
         for i := 0 to cR do
           begin
              if (frm_Main.tg_Report.Cells[10,i]) = 'Да'  then
                begin
                  for Ii:=0 to Cc do frm_Main.tg_Report.Cell[Ii,i].Color := $00CEEFB8;
                end;
            end;
      end;
end;

//..............................................................................Автоподбор ширины колонок при выводе отчетов
procedure frm_Main_tg_Report_OnChange (Sender: TObject);
begin
    frm_Main.tg_Report.BestFitColumns(bfBoth);
    frm_Main.tg_Report.Columns[0].Alignment:= tacenter;
    frm_Main.tg_Report.Columns[1].Alignment:= tacenter;
end;

//..............................................................................Отчет по количеству сторон по заказчикам, форматам и работам
procedure frm_Main_Button14_OnClick (Sender: TObject; var Cancel: boolean);
var
    date_start, date_end : string;
    id_customer : integer;
begin

    date_start:= frm_Main.dateStartReport.sqlDate ;
    date_end:= frm_Main.dateEndReport.sqlDate ;
    id_customer:= frm_Main.cbCustomerReport.dbItemID;

    if ((date_start = 'NULL') OR (date_end = 'NULL'))
        then ShowMessage('Выберите даты начала и окончания периода!')
    else
        begin
            frm_Main.tg_Report.dbSQL:= ' SELECT '+
            ' t_Customer.customer_name AS "Заказчик", '+
            ' t_Format.format_name AS "Формат", '+
            ' t_Work.work_name AS "Работа", '+
            ' Count(t_Adres_Task.id) AS "Кол-во сторон" '+
            ' FROM '+
            ' t_Task '+
            ' INNER JOIN t_Adres_Task ON t_Adres_Task.id_t_Task = t_Task.id '+
            ' INNER JOIN t_Customer ON t_Task.id_t_Customer = t_Customer.id '+
            ' INNER JOIN t_Format ON t_Adres_Task.id_t_Format = t_Format.id '+
            ' INNER JOIN t_Work ON t_Adres_Task.id_t_Work = t_Work.id '+
            ' WHERE (CASE WHEN ' + IntToStr(id_customer) +  '<> -1 THEN t_Task.id_t_Customer = ' + IntToStr(id_customer) + ' ELSE 1=1 END) ' +
            ' AND t_Adres_Task.date BETWEEN ' + date_start + 'AND' + date_end +
            ' GROUP BY '+
            ' t_Task.id_t_Customer, '+
            ' t_Adres_Task.id_t_Format, '+
            ' t_Adres_Task.id_t_Work, '+
            ' t_Customer.customer_name, '+
            ' t_Format.format_name, '+
            ' t_Work.work_name ';
            frm_Main.tg_Report.dbSQLExecute;
        end;
end;

 //..............................................................................Отчет по зарплате
procedure frm_Main_Button12_OnClick (Sender: TObject; var Cancel: boolean);
var
    date_start, date_end, comleted_work : string;
    id_worker : integer;
begin

    date_start:= frm_Main.dateStartReport.sqlDate ;
    date_end:= frm_Main.dateEndReport.sqlDate ;
    id_worker:= frm_Main.cbWorkerReport.dbItemID;
    comleted_work:= frm_Main.chbCompletedWork.sqlValue;

    if ((date_start = 'NULL') OR (date_end = 'NULL'))
        then ShowMessage('Выберите даты начала и окончания периода!')
    else
        begin
             frm_Main.tg_Report.dbSQL:= ' SELECT ' +
            ' CONCAT(t_Worker.last_name, " ", t_Worker.first_name) AS `Исполнитель`, ' +
            ' SUM(t_Adres_Task.price_work / t_Task.num_workers) AS `Сумма` ' +
            ' FROM t_Adres_Task ' +
            ' INNER JOIN t_Task ON t_Adres_Task.id_t_Task = t_Task.id ' +
            ' INNER JOIN t_Work ON t_Adres_Task.id_t_Work = t_Work.id ' +
            ' INNER JOIN t_Worker_Task ON t_Task.id = t_Worker_Task.id_t_Task  ' +
            ' INNER JOIN t_Worker ON t_Worker_Task.id_t_Worker = t_Worker.id  ' +
            ' WHERE t_Adres_Task.date BETWEEN ' + date_start + 'AND' + date_end +
            ' AND (CASE WHEN ' + IntToStr(id_worker) +  '<> -1 THEN t_Worker_Task.id_t_Worker = ' + IntToStr(id_worker) + ' ELSE 1=1 END) ' +
            ' AND (CASE WHEN ' + comleted_work +  '= 1 THEN t_Adres_Task.task_status = ' + comleted_work + ' ELSE 1=1 END) ' +
            ' GROUP BY ' +
            ' t_Worker_Task.id_t_Worker ';
            frm_Main.tg_Report.dbSQLExecute;
        end;
end;

 //..............................................................................Отчет сторонам, постерам, заказчикам и монтажникам
procedure frm_Main_Button13_OnClick (Sender: TObject; var Cancel: boolean);
var
    date_start, date_end, comleted_work : string;
    id_worker : integer;
begin

    date_start:= frm_Main.dateStartReport.sqlDate ;
    date_end:= frm_Main.dateEndReport.sqlDate ;
    id_worker:= frm_Main.cbWorkerReport.dbItemID;
    comleted_work:= frm_Main.chbCompletedWork.sqlValue;

    if ((date_start = 'NULL') OR (date_end = 'NULL'))
        then ShowMessage('Выберите даты начала и окончания периода!')
    else
        begin
             frm_Main.tg_Report.dbSQL:= ' SELECT ' +
                ' t_Task.id AS `№ Задания`, ' +
                ' DATE_FORMAT(t_Task.date, "%d.%m.%Y") AS `Дата задания`, ' +
                ' CONCAT(t_Worker.last_name, " ", t_Worker.first_name) AS `Исполнитель`, ' +
                ' t_Customer.customer_name AS `Заказчик`, ' +
                ' t_Task.num_workers AS `Кол-во исп.`, ' +
                ' t_Format.format_name AS `Формат`, ' +
                ' t_Work.work_name AS `Работы`, ' +
                ' t_Adres.adres AS `Адрес`, ' +
                ' t_Place.place_name AS `Сторона`, ' +
                ' DATE_FORMAT(t_Adres_Task.date, "%d.%m.%Y") AS `Выдано на:`, ' +
                ' t_Adres_Task.old_poster AS `Старый постер`, ' +
                ' t_Adres_Task.new_poster AS `Новый постер` ' +
                ' FROM t_Adres_Task ' +
                ' INNER JOIN t_Task ON t_Adres_Task.id_t_Task = t_Task.id ' +
                ' INNER JOIN t_Worker_Task ON t_Task.id = t_Worker_Task.id_t_Task ' +
                ' INNER JOIN t_Worker ON t_Worker_Task.id_t_Worker = t_Worker.id ' +
                ' INNER JOIN t_Customer ON t_Task.id_t_Customer = t_Customer.id ' +
                ' INNER JOIN t_Format ON t_Adres_Task.id_t_Format = t_Format.id ' +
                ' INNER JOIN t_Work ON t_Adres_Task.id_t_Work = t_Work.id ' +
                ' INNER JOIN t_Adres ON t_Adres_Task.id_t_Adres = t_Adres.id AND t_Customer.id = t_Adres.id_t_Customer AND t_Format.id = t_Adres.id_t_Format ' +
                ' INNER JOIN t_Place ON t_Adres_Task.id_t_Place = t_Place.id ' +
                ' WHERE t_Adres_Task.date BETWEEN ' + date_start + 'AND' + date_end +
                ' AND (CASE WHEN ' + IntToStr(id_worker) +  '<> -1 THEN t_Worker_Task.id_t_Worker = ' + IntToStr(id_worker) + ' ELSE 1=1 END) ' +
                ' AND (CASE WHEN ' + comleted_work +  '= 1 THEN t_Adres_Task.task_status = ' + comleted_work + ' ELSE 1=1 END) ' +
                ' AND t_Task.id = t_Worker_Task.id_t_Task ' +
                ' AND t_Task.id = t_Adres_Task.id_t_Task ' +
                ' ORDER BY t_Worker_Task.id_t_Worker ASC, t_Task.id_t_Customer ASC, t_Adres_Task.date ASC ';
            frm_Main.tg_Report.dbSQLExecute;
        end;

end;


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


//====================================== frm_Task_Adres ==================================

procedure frm_Task_Adres_OnShow (Sender: TObject; Action: string);
    var
    id_address : integer;
    create_date : string;
    TempCustomerTask : integer;
begin




                id_address :=  frm_Task_Adres.cb_Adres_F_Task_Adres.dbItemID;
                create_date :=  frm_Task.create_date.sqlDate;
                frm_Task_Adres.tg_Posters.dbSQL := 'SELECT '+
                ' t_Place.place_name AS "Сторона", '+
                ' t_Adres_Task.new_poster AS "Постер", '+
                ' DATE_FORMAT(t_Adres_Task.date, "%d.%m.%Y") AS "Дата" '+
                ' FROM t_Task '+
                ' INNER JOIN t_Adres_Task ON t_Adres_Task.id_t_Task = t_Task.id '+
                ' INNER JOIN t_Place ON t_Adres_Task.id_t_Place = t_Place.id '+
                ' WHERE t_Adres_Task.id_t_Adres = ' + inttostr(id_address) +
                ' GROUP BY t_Adres_Task.id_t_Place '+
                ' HAVING MAX(t_Adres_Task.date) <= ' + create_date;
                frm_Task_Adres.tg_Posters.dbSQLExecute;

//................................................................Заполнение комбобокса "Формат" при выдаче задания в зависимости от заказчика.
    TempCustomerTask:= frm_Task.cb_Customer_F_Task.ItemIndex;
    if (frm_Task_Adres.cb_Format_F_Task_Adres.ItemIndex <= 0) then
       begin
        frm_Task_Adres.cb_Format_F_Task_Adres.dbSQLExecute ('SELECT t_Format.id AS id, t_Format.format_name ' +
        ' FROM t_Format ' +
        ' INNER JOIN t_Adres ON t_Adres.id_t_Format = t_Format.id ' +
        ' WHERE t_Adres.id_t_Customer = ' + IntToStr(TempCustomerTask) +
        ' GROUP BY t_Format.id ' );
       end
     else
        begin
        end;

end;

// ..........................................................................Фильтрование адресов задания в комбобоксе в зависимомти от заказчика
procedure FilterForAdres (Customer : integer);
begin
     if Customer > 0 then
      begin
        frm_Task_Adres.cb_Adres_F_Task_Adres.dbFilter := 'id_t_Customer =' + IntToStr(Customer);
        frm_Task_Adres.cb_Adres_F_Task_Adres.dbUpdate;
      end;
end;

procedure frm_Task_Adres_cb_Format_F_Task_Adres_OnChange (Sender: TObject);
var
TempCustomerTask : integer;
begin
TempCustomerTask := frm_Task.cb_Customer_F_Task.ItemIndex;
   FilterForAdres(TempCustomerTask);
end;

//............................................................................Загрузка актуальной цены при выборе работы
 procedure frm_Task_Adres_cb_Work_F_Task_Adres_OnChange (Sender: TObject);
var
    id_Format, id_Work : integer;
    Price : double;
begin
    id_Format := frm_Task_Adres.cb_Format_F_Task_Adres.dbItemID;
    id_Work := frm_Task_Adres.cb_Work_F_Task_Adres.dbItemID;

    if id_Work <> -1 then Price := SQLExecute('SELECT price FROM t_Price WHERE id_t_format='+IntToStr(id_Format)+' AND id_t_work='+IntToStr(id_Work)+
                                              ' ORDER BY date DESC LIMIT 1 ');

    frm_Task_Adres.editPriceWork.Text := FloatToStr(Price);
end;

//..........................................................................Отображение текущего размещения на сторонах при выдаче задания
procedure frm_Task_Adres_Task_OnChage (Sender: TObject; Action: string);

var
    id_address : integer;
    create_date : string;
begin

                id_address :=  frm_Task_Adres.cb_Adres_F_Task_Adres.dbItemID;
                create_date :=  frm_Task.create_date.sqlDate;


                frm_Task_Adres.tg_Posters.dbSQL:= 'SELECT '+
                ' t_Place.place_name AS "Сторона", '+
                ' t_Adres_Task.new_poster AS "Постер", '+
                ' DATE_FORMAT(t_Adres_Task.date, "%d.%m.%Y") AS "Дата" '+
                ' FROM t_Task '+
                ' INNER JOIN t_Adres_Task ON t_Adres_Task.id_t_Task = t_Task.id '+
                ' INNER JOIN t_Place ON t_Adres_Task.id_t_Place = t_Place.id '+
                ' WHERE t_Adres_Task.id_t_Adres = ' + inttostr(id_address) +
                ' GROUP BY t_Adres_Task.id_t_Place '+
                ' HAVING MAX(t_Adres_Task.date) <= ' + create_date;

                frm_Task_Adres.tg_Posters.dbSQLExecute;



        frm_Task_Adres.cb_Place_F_Task_Adres.dbSQLExecute (' SELECT t_Place.id AS id, t_Place.place_name ' +
        ' FROM t_Place_Adres ' +
        ' INNER JOIN t_Place ON t_Place_Adres.id_t_Place = t_Place.id ' +
        ' INNER JOIN t_Adres ON t_Place_Adres.id_t_Adres = t_Adres.id ' +
        ' WHERE t_Adres.id = ' + IntToStr(id_address) );


end;

//...........................................................................Запрос для заполнения старого постера при выдаче задания
procedure cb_Place_F_Task_Adres_OnChange (Sender: TObject);
var
    id_address, id_side : integer;
    create_date, old_poster : string;
begin
                id_address :=  frm_Task_Adres.cb_Adres_F_Task_Adres.dbItemID;
                id_side :=  frm_Task_Adres.cb_Place_F_Task_Adres.dbItemID;
                create_date :=  frm_Task.create_date.sqlDate;


                 old_poster := SQLExecute ('SELECT t_Adres_Task.new_poster '+
                ' FROM t_Task '+
                ' INNER JOIN t_Adres_Task ON t_Adres_Task.id_t_Task = t_Task.id '+
                ' WHERE t_Adres_Task.id_t_Adres = ' + inttostr(id_address) + ' AND ' + ' t_Adres_Task.id_t_Place = ' + inttostr(id_side) +
                ' GROUP BY t_Adres_Task.id_t_Place '+
                ' HAVING MAX(t_Adres_Task.date) <= ' + create_date);
                frm_Task_Adres.txt_Old_Poster.Text := old_poster;

end;

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  
begin
end.

