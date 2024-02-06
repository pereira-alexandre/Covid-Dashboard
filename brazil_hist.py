import requests
import pandas as pd
url = "https://api.apify.com/v2/datasets/3S2T1ZBxB9zhRJTBB/items?format=json&clean=1"
response = requests.get(url)

# Check if the request was successful
if response.status_code == 200:
    data = response.json()
    print(data)
else:
    print("Failed to retrieve data")


#Convert data to a DataFrame
df_brazil_hist = pd.DataFrame(data)

