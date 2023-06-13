Sub StockYears()

For Each ws In Worksheets

    ws.Activate
    
    Dim worksheetname As String
    worksheetname = ws.Name

    'Constants
    Const FIRST_DATA_ROW As Integer = 2
    
    'Create variables for the open, close and volume
    Dim openprice As Double
    Dim closeprice As Double
    Dim delta_price As Double
    Dim delta_price_frac As Double
    Dim volume As LongLong
    Dim greatest_volume As LongLong
    Dim greatest_Increase_value As Double
    Dim greatest_Increase_ticker As String
    Dim greatest_decrease_value As Double
    Dim greatest_decrease_ticker As String
    Dim greatest_volume_ticker As String
    
    'Create Ticker as String
    Dim Ticker As String
    Dim NextTicker As String
    Dim input_row, output_row As Long
    
    Dim last_row As Double
    
    'Establish Sheet Range and Values
        last_row = Cells(Rows.Count, 1).End(xlUp).Row
        volume = 0
        openprice = Cells(FIRST_DATA_ROW, 3).Value
        output_row = FIRST_DATA_ROW
        greatest_Increase_value = -999999
        greatest_decrease_value = 0
        greatest_volume = 0
        
    'Write Column Names
        Cells(1, 9).Value = "Ticker"
        Cells(1, 10).Value = "Yearly Change"
        Cells(1, 11).Value = "Percent Change"
        Cells(1, 12).Value = "Total Stock Volume"
                    
        For input_row = FIRST_DATA_ROW To last_row
            'Initialize Ticker and NextTicker
            Ticker = Cells(input_row, 1).Value
            NextTicker = Cells(input_row + 1, 1).Value
            volume = Cells(input_row, 7).Value + volume
            
            If Ticker <> NextTicker Then
                'Process last row of current stock
                'Input
                closeprice = Cells(input_row, 6).Value
                
                'Calculations
                delta_price = closeprice - openprice
                delta_price_frac = delta_price / openprice
                
                    'Greatest % Increase Calc
                    If delta_price_frac > greatest_Increase_value Then
                    greatest_Increase_value = delta_price / openprice
                    greatest_Increase_ticker = Ticker
                    End If
                    
                    'Greatest decrease Calc
                    If delta_price_frac < greatest_decrease_value Then
                    greatest_decrease_value = delta_price / openprice
                    greatest_decrease_ticker = Ticker
                    End If
                    
                    'Greatest volume
                    If volume > greatest_volume Then
                    greatest_volume = volume
                    greatest_volume_ticker = Ticker
                    End If
                
                
                'Output
                Cells(output_row, 9).Value = Ticker
                Cells(output_row, 10).Value = delta_price
                If delta_price < 0 Then
                    Cells(output_row, 10).Interior.ColorIndex = 3
                End If
                If delta_price >= 0 Then
                    Cells(output_row, 10).Interior.ColorIndex = 4
                End If
                Cells(output_row, 11).Value = FormatPercent(delta_price_frac)
                Cells(output_row, 13).Value = volume
                
                'Prepare for next stock
                openprice = Cells(input_row + 1, 3).Value
                output_row = output_row + 1
                volume = 0
                
             End If
         
        Next input_row
        
        'Output greatest increase and decrease and volume
        Cells(2, 15).Value = "Greatest % Increase"
        Cells(3, 15).Value = "Greatest % Decrease"
        Cells(4, 15).Value = "Greatest Total Volume"
        Cells(2, 17).Value = FormatPercent(greatest_Increase_value)
        Cells(2, 16).Value = greatest_Increase_ticker
        Cells(3, 17).Value = FormatPercent(greatest_decrease_value)
        Cells(3, 16).Value = greatest_decrease_ticker
        Cells(4, 17).Value = greatest_volume
        Cells(4, 16).Value = greatest_volume_ticker
        MsgBox ("Worksheet Name" + worksheetname)
        
    Next ws
        
End Sub



