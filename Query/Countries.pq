let
    DataPath = "C:\Users\alexandre.pereira\Desktop\Projetos & Estudos\Estudos\Pessoais\PowerBI\Covid-19 Dashboard\",


    Source = Csv.Document(File.Contents(DataPath & "countries.csv"),[Delimiter=",", Columns=6, Encoding=1252, QuoteStyle=QuoteStyle.None]),

    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),

    DataType = Table.TransformColumnTypes(Headers,
    {
        {"country", type text}, {"cases", type text}, {"confirmed", Int64.Type}, 
        {"deaths", Int64.Type}, {"recovered", type text}, {"updated_at", type datetime}
        }
    )

in
    DataType