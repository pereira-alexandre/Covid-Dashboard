import pandas as pd

data = [
    {'state': 'RO', 'count': 0}, {'state': 'AC', 'count': 0}, 
    {'state': 'AM', 'count': 1}, {'state': 'RR', 'count': 0}, 
    {'state': 'PA', 'count': 0}, {'state': 'AP', 'count': 0}, 
    {'state': 'TO', 'count': 0}, {'state': 'MA', 'count': 0}, 
    {'state': 'PI', 'count': 0}, {'state': 'CE', 'count': 5}, 
    {'state': 'RN', 'count': 1}, {'state': 'PB', 'count': 0}, 
    {'state': 'PE', 'count': 16}, {'state': 'AL', 'count': 1}, 
    {'state': 'SE', 'count': 4}, {'state': 'BA', 'count': 3}, 
    {'state': 'MG', 'count': 7}, {'state': 'ES', 'count': 1}, 
    {'state': 'RJ', 'count': 33}, {'state': 'SP', 'count': 164}, 
    {'state': 'PR', 'count': 6}, {'state': 'SC', 'count': 7}, 
    {'state': 'RS', 'count': 10}, {'state': 'MS', 'count': 4}, 
    {'state': 'MT', 'count': 0}, {'state': 'GO', 'count': 6}, 
    {'state': 'DF', 'count': 21}
    ]

df = pd.DataFrame(data)

print(df)
