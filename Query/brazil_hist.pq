let
    Fonte = Python.Execute("import requests#(lf)import pandas as pd#(lf)url = ""https://api.apify.com/v2/datasets/3S2T1ZBxB9zhRJTBB/items?format=json&clean=1""#(lf)response = requests.get(url)#(lf)#(lf)# Check if the request was successful#(lf)if response.status_code == 200:#(lf)    data = response.json()#(lf)    print(data)#(lf)else:#(lf)    print(""Failed to retrieve data"")#(lf)#(lf)#(lf)#Convert data to a DataFrame#(lf)df_brazil_hist = pd.DataFrame(data)#(lf)#(lf)"),

    df_brazil_hist1 = Fonte{[Name="df_brazil_hist"]}[Value],

    ChangeType = Table.TransformColumnTypes(
        df_brazil_hist1, 
        {
            {"totalTested", Int64.Type}, {"testedNotInfected", Int64.Type}, 
            {"infected", Int64.Type}, {"deceased", Int64.Type}, 
            {"infectedByRegion", type text}, {"sourceUrl", type text}, 
            {"lastUpdatedAtSource", type datetime}, {"lastUpdatedAtApify", type datetime}, 
            {"readMe", type text}, {"testedByRegion", type text}, 
            {"testedNotInfectedByRegion", type text}, {"deceasedByRegion", type text}, 
            {"suspiciousCases", Int64.Type}, {"suspiciousCasesByRegion", type text}, 
            {"version", Int64.Type}, {"country", type text}, 
            {"historyData", type text}, {"tested", type text}, 
            {"recovered", type text}
        }
    ),

    RemoveColumns = Table.RemoveColumns(
        ChangeType, 
        {
            "sourceUrl", "readMe", "testedByRegion", "version", 
            "tested", "recovered", "historyData", "suspiciousCasesByRegion", 
            "suspiciousCases", "infectedByRegion", "testedNotInfectedByRegion", 
            "deceasedByRegion"
        }
    ),
    
    AjustDateType = Table.TransformColumnTypes(RemoveColumns,
    {
        {"lastUpdatedAtSource", type date}, 
        {"lastUpdatedAtApify", type date}
    }
), 


    // Sort By Date
    SortedRows = Table.Sort(AjustDateType,{{"lastUpdatedAtSource", Order.Ascending}}),


    IndexStart0 = Table.AddIndexColumn(SortedRows, "Índice", 0, 1, Int64.Type),
    IndexStart1 = Table.AddIndexColumn(IndexStart0, "Índice.1", 1, 1, Int64.Type),

    // Merge Index0 With Index1
    MergeItselff = Table.NestedJoin(IndexStart1, {"Índice"}, IndexStart1, {"Índice.1"}, "IndexStart1", JoinKind.LeftOuter),

    Expand = Table.ExpandTableColumn(MergeItselff, "IndexStart1", {"deceased"}, {"deceased.1"}),

    
    Sort = Table.Sort(Expand,{{"Índice", Order.Ascending}}),

    Subtraction = Table.AddColumn(Sort, "Subtraction", each [deceased] - [deceased.1], Int64.Type),

    RemoveOtherColumns = Table.SelectColumns(Subtraction,{"deceased", "lastUpdatedAtSource", "Subtraction"})
    
in
    RemoveOtherColumns