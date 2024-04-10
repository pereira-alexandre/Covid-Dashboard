let
    Fonte = Python.Execute("# https://covid19-brazil-api-docs.vercel.app/#(lf)#(lf)#(lf)import requests#(lf)import pandas as pd#(lf)#(lf)url_brazil = 'https://covid19-brazil-api.now.sh/api/report/v1'#(lf)url_countries = 'https://covid19-brazil-api.now.sh/api/report/v1/countries'#(lf)headers = {} # Add necessary headers here#(lf)params = {} # Add necessary parameters here#(lf)#(lf)#(lf)brazil_response = requests.get(url_brazil, headers=headers, params=params)#(lf)print( f'This is the data from da response: {brazil_response.text}' )#(lf)#(lf)#Parse the JSON response#(lf)brazil_data = brazil_response.json()['data']#(lf)#(lf)#Convert the data to a DataFrame#(lf)df_brazil = pd.DataFrame(brazil_data)#(lf)#(lf)#(lf)countries_response = requests.get(url_countries, headers=headers, params=params)#(lf)print( f'This is the data from the response: {countries_response.text}' )#(lf)countries_data = countries_response.json()['data']#(lf)df_countries = pd.DataFrame(countries_data)#(lf)"),

    df_countries = Fonte{[Name="df_countries"]}[Value],

    dataType = Table.TransformColumnTypes(df_countries,
    {
        {"country", type text}, {"confirmed", Int64.Type}, 
        {"deaths", Int64.Type}, {"updated_at", type datetime}
        }
    ),
    joinContinents = Table.NestedJoin(dataType, {"country"}, dContinents, {"Pais"}, "dContinents", JoinKind.LeftOuter),
    expandContinents = Table.ExpandTableColumn(joinContinents, "dContinents", {"Continente"}, {"Continente"}),
    cleansNulls = Table.ReplaceValue(expandContinents,null,"Others",Replacer.ReplaceValue,{"Continente"})
in
    cleansNulls