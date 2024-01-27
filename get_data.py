# https://covid19-brazil-api-docs.vercel.app/


import requests
import pandas as pd


url_brazil = 'https://covid19-brazil-api.now.sh/api/report/v1'
url_countries = 'https://covid19-brazil-api.now.sh/api/report/v1/countries'
headers = {} # Add necessary headers here
params = {} # Add necessary parameters here


brazil_response = requests.get(url_brazil, headers=headers, params=params)
print( f'This is the data from da response: {brazil_response.text}' )

#Parse the JSON response
brazil_data = brazil_response.json()['data']

#Convert the data to a DataFrame
df_brazil = pd.DataFrame(brazil_data)

#Export the DataFrame to a CSV file
df_brazil.to_csv('brazil.csv', index=False)


countries_response = requests.get(url_countries, headers=headers, params=params)
print( f'This is the data from the response: {countries_response.text}' )
countries_data = countries_response.json()['data']
df_countries = pd.DataFrame(countries_data)
df_countries.to_csv('countries.csv', index=False)


