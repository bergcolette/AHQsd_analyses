import pandas as pd
import numpy as np
from pandas.api.types import is_string_dtype
from pandas.api.types import is_numeric_dtype
import glob

# read in the list of files
data_list_genotypes = glob.glob('/Users/coletteberg/Documents/UMontana/Research/YNP/AHQsd/AHQsd*.012')
data_list_sites = glob.glob('/Users/coletteberg/Documents/UMontana/Research/YNP/AHQsd/AHQsd*.012.pos')
data_list_indvs = pd.read_csv('/Users/coletteberg/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr1.012.indv',names=['ind

#functions for concatenating
def load_files_g(data_list):
    for i in data_list:
        yield pd.read_csv(i, sep="\t", index_col=False, header=None).iloc[:, 1:]
        
def load_files_s(data_list):
    for i in data_list:
        yield pd.read_csv(i, sep="\t", index_col=False, header=None)
   
# use the functions to read in / concatenate 
data_genotypes = pd.concat(load_files_g(data_list_genotypes), axis=1)
data_sites = pd.concat(load_files_s(data_list_sites), axis=0)

# stuff for renaming columns
tmpDF = pd.DataFrame(columns=['scaffold','chr'])
tmpDF[['scaffold','chr']] = data_sites[0].str.split('_', expand=True)

data_sites['chr'] = tmpDF['chr']
data_sites['site'] = data_sites['chr'].astype(str) + ['_'] + data_sites[1].astype(str)
data_genotypes.columns = data_sites['site']
data_genotypes.insert(0, 'indv', data_list_indvs['ind'])
data_genotypes['indv'] = data_genotypes['indv'].str.split('/processed/',expand=True)[1]

# make it a parquet file
data_genotypes.to_parquet("AHQsd_F2_genotypes_raw.parquet")