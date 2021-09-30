#%%
 
import pandas as pd
from scipy.sparse import data
import sqlalchemy

dir_local = os.path.dirname(os.path.abspath('__file__'))
dir_project = os.path.dirname(dir_local)
dir_db = os.path.join(dir_project,'Data/olist.db')

con = sqlalchemy.create_engine('sqlite:///'+ dir_db)

load_abt_churn = "SELECT * from tb_abt_churn"

dataset = pd.read_sql(load_abt_churn , con)
#%%
dataset
# %%
ultimas_safras = dataset['data_lim_safra'].unique()
# %%
duas_ultimas = ultimas_safras[-2:]
# %%
df_oot = dataset[dataset['data_lim_safra']>=duas_ultimas[0]]
# %%
df_oot
# %%
