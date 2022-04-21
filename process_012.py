from sys import argv
import pandas as pd
import numpy as np
import os
from pandas.api.types import is_string_dtype
from pandas.api.types import is_numeric_dtype
import glob

script, path, indFile, outfile = argv

# this script takes 3 arguments: /path/to/file/, the name of the file with individual names (with extension) and the output file name.
# the result is a .parquet file of genotypes. 

# read in the list of files
data_list_genotypes = glob.glob(os.path.join(path, '*.012'))
data_list_indvs = glob.glob(os.path.join(path, '*.012.indv'))
data_list_sites = glob.glob(os.path.join(path, '*.012.pos'))

data_list_indvs = pd.read_csv((os.path.join(path, indFile)),names=['ind'], index_col=False)

def load_files_g(data_list):
    for i in data_list:
        yield pd.read_csv(i, sep="\t", index_col=False, header=None).iloc[:, 1:]
        
def load_files_s(data_list):
    for i in data_list:
        yield pd.read_csv(i, sep="\t", index_col=False, header=None)
        
data_genotypes = pd.concat(load_files_g(data_list_genotypes), axis=1)

data_sites = pd.concat(load_files_s(data_list_sites), axis=0)

tmpDF = pd.DataFrame(columns=['scaffold','chr'])
tmpDF[['scaffold','chr']] = data_sites[0].str.split('_', expand=True)

data_sites['chr'] = tmpDF['chr']

data_sites['site'] = data_sites['chr'].astype(str) + ['_'] + data_sites[1].astype(str)

data_genotypes.columns = data_sites['site']

data_genotypes.insert(0, 'indv', data_list_indvs['ind'])

data_genotypes['indv'] = data_genotypes['indv'].str.split('/processed/',expand=True)[1]

data_genotypes.to_parquet(outfile)