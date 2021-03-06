Attribute VB_Name = "Module1"
 Sub MultiYearStockData()
   
    'loop through each worksheet
    For Each ws In ThisWorkbook.Worksheets
        
        'set definition
        Dim ticker As String
        Dim vol As Double
        Dim year_open As Double
        Dim year_close As Double
        Dim yearly_change As Double
        Dim percent_change As Double
        Dim Summary_Table_Row As Integer
        Summary_Table_Row = 1
        vol = 0
        
        'set headers for summary table
        ws.Cells(1, 9).Value = "Ticker"
        ws.Cells(1, 10).Value = "Volume"
        ws.Cells(1, 11).Value = "Yearly Change"
        ws.Cells(1, 12).Value = "Percent Change"
        
        'set ticker
        ticker = ""
        
        'set last row
        LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
        
        'begin loop
        For i = 2 To LastRow
            If ticker <> ws.Cells(i, 1).Value Then
                'ticker changed
                If ticker <> "" Then
                    'finish previous summary table row
                    year_close = ws.Cells(i - 1, 6).Value
                    yearly_change = year_close - year_open
                    
                    If (year_open = 0 And year_close = 0) Then
                        percent_change = 0
                    ElseIf (year_open = 0 And year_close <> 0) Then
                        percent_change = 1
                    Else
                        percent_change = yearly_change / year_open
                    End If
                    ws.Range("J" & Summary_Table_Row).Value = vol
                    vol = o
                    ws.Range("K" & Summary_Table_Row).Value = yearly_change
                    ws.Range("L" & Summary_Table_Row).Value = percent_change
                    ws.Cells(Summary_Table_Row, 12).NumberFormat = "0.00%"
                End If
                    'start summary row for next ticker
                    Summary_Table_Row = Summary_Table_Row + 1
                    ticker = ws.Cells(i, 1).Value
                    year_open = ws.Cells(i, 3).Value
                    ws.Range("I" & Summary_Table_Row).Value = ticker
                End If
                vol = vol + ws.Cells(i, 7).Value
                If i = LastRow Then
                    year_close = ws.Cells(i - 1, 6).Value
                    yearly_change = year_close - year_open
                
                    If (year_open = 0 And year_close = 0) Then
                        percent_change = 0
                    ElseIf (year_open = 0 And year_close <> 0) Then
                        percent_change = 1
                    Else
                        percent_change = yearly_change / year_open
                    End If
                    ws.Range("J" & Summary_Table_Row).Value = vol
                    vol = 0
                    ws.Range("K" & Summary_Table_Row).Value = yearly_change
                    ws.Range("L" & Summary_Table_Row).Value = percent_change
                    ws.Cells(Summary_Table_Row, 12).NumberFormat = "0.00%"
                End If
            Next i
                
        'set Yearly Change last row
        YearChangeLastRow = ws.Cells(Rows.Count, 9).End(xlUp).Row
        

    'Set conditional formatting
        For j = 2 To ws.Cells(Rows.Count, 9).End(xlUp).Row
            If ws.Cells(j, 11).Value >= 0 Then
                ws.Cells(j, 11).Interior.ColorIndex = 4
            ElseIf ws.Cells(j, 11).Value < 0 Then
                ws.Cells(j, 11).Interior.ColorIndex = 3
            End If
        Next j
        
        'Set Greatest % Increase, % Decrease, and Total Volume
        ws.Cells(2, 15).Value = "Greatest % Increase"
        ws.Cells(3, 15).Value = "Greatest % Decrease"
        ws.Cells(4, 15).Value = "Greatest Total Volume"
        ws.Cells(1, 16).Value = "Ticker"
        ws.Cells(1, 17).Value = "Value"
        
        'loop thru each row to find the greatest value and its ticker
        For k = 2 To YearChangeLastRow
            If ws.Cells(k, 12).Value = Application.WorksheetFunction.Max(ws.Range("L2:L" & ws.Cells(Rows.Count, 9).End(xlUp).Row)) Then
                ws.Cells(2, 16).Value = ws.Cells(k, 9).Value
                ws.Cells(2, 17).Value = ws.Cells(k, 12).Value
                ws.Cells(2, 17).NumberFormat = "0.00%"
            ElseIf ws.Cells(k, 12).Value = Application.WorksheetFunction.Min(ws.Range("L2:L" & ws.Cells(Rows.Count, 9).End(xlUp).Row)) Then
                ws.Cells(3, 16).Value = ws.Cells(k, 9).Value
                ws.Cells(3, 17).Value = ws.Cells(k, 12).Value
                ws.Cells(3, 17).NumberFormat = "0.00%"
            ElseIf ws.Cells(k, 10).Value = Application.WorksheetFunction.Max(ws.Range("J2:J" & ws.Cells(Rows.Count, 9).End(xlUp).Row)) Then
                ws.Cells(4, 16).Value = ws.Cells(k, 9).Value
                ws.Cells(4, 17).Value = ws.Cells(k, 10).Value
            End If
        Next k

    Next ws

End Sub
