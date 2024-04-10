let
    Fonte = Excel.Workbook(File.Contents("C:\Users\alexandre.pereira\Documents\Projetos\Pessoal\BI\Power BI\Covid-Dashboard\src\imf-dm-export-20240408.xls"), null, true),
    PCPIPCH1 = Fonte{[Name="PCPIPCH"]}[Data],
    RemoveBlank = Table.SelectRows(PCPIPCH1, each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),

    DropForecast = Table.RemoveColumns(RemoveBlank,{"Column46", "Column47", "Column48", "Column49", "Column50"}),

    Header = Table.PromoteHeaders(DropForecast, [PromoteAllScalars=true]),

    DataType = Table.TransformColumnTypes(
        Header, 
        {
            {"Inflation rate, average consumer prices (Annual percent change)", type text}, {"1980", type text}, {"1981", type text}, {"1982", type text}, 
            {"1983", type text}, {"1984", type text}, {"1985", type text}, {"1986", type text}, {"1987", type text}, {"1988", type text}, {"1989", type text}, 
            {"1990", type text}, {"1991", type text}, {"1992", type text}, {"1993", type text}, {"1994", type text}, {"1995", type text}, {"1996", type text}, 
            {"1997", type text}, {"1998", type text}, {"1999", type text}, {"2000", type text}, {"2001", type text}, {"2002", type number}, {"2003", type number}, 
            {"2004", type number}, {"2005", type number}, {"2006", type number}, {"2007", type number}, {"2008", type number}, {"2009", type number}, {"2010", type number}, 
            {"2011", type number}, {"2012", type number}, {"2013", type number}, {"2014", type number}, {"2015", type number}, {"2016", type number}, {"2017", type number}, 
            {"2018", type number}, {"2019", type number}, {"2020", type number}, {"2021", type number}, {"2022", type number}, {"2023", type text}
        }
    ),
    ColumnToLine = Table.UnpivotOtherColumns(DataType, {"Inflation rate, average consumer prices (Annual percent change)"}, "Atributo", "Valor"),

    FillEmpty = Table.ReplaceValue(ColumnToLine,"no data",0,Replacer.ReplaceValue,{"Valor"}),
    
    ChangeDataType = Table.TransformColumnTypes(FillEmpty,{{"Valor", type number}, {"Atributo", type date}}),
    
    RenameColumns = Table.RenameColumns(ChangeDataType,{{"Atributo", "Date"}, {"Valor", "Inflation rate (Annual percent change)"}, {"Inflation rate, average consumer prices (Annual percent change)", "Location"}})
in
    RenameColumns