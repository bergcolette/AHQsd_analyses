# set the working directory

setwd("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_analyses/")

## pipeline for processing .012 data as it comes (with no excel steps)

## put the 012 data into the 012_files folder on the desktop using fileZilla. 

library(dplyr)
library(reshape2)
library(stringr)
library(ggplot2)
library(expss)
library(arrow)

# read in chromosome files
chr1 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr1.012", sep="\t", header = FALSE)
chr2 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr2.012", sep="\t", header = FALSE)
chr3 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr3.012", sep="\t", header = FALSE)
chr4 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr4.012", sep="\t", header = FALSE)
chr5 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr5.012", sep="\t", header = FALSE)
chr6 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr6.012", sep="\t", header = FALSE)
chr7 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr7.012", sep="\t", header = FALSE)
chr8 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr8.012", sep="\t", header = FALSE)
chr9 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr9.012", sep="\t", header = FALSE)
chr10 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr10.012", sep="\t", header = FALSE)
chr11 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr11.012", sep="\t", header = FALSE)
chr12 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr12.012", sep="\t", header = FALSE)
chr13 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr13.012", sep="\t", header = FALSE)
chr14 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr14.012", sep="\t", header = FALSE)

#take away column 1

chr1 <-select(chr1, -1)
chr2 <- select(chr2, -1)
chr3 <- select(chr3, -1)
chr4 <- select(chr4, -1)
chr5 <- select(chr5, -1)
chr6 <- select(chr6, -1)
chr7 <- select(chr7, -1)
chr8 <- select(chr8, -1)
chr9 <- select(chr9, -1)
chr10 <- select(chr10, -1)
chr11 <- select(chr11, -1)
chr12 <- select(chr12, -1)
chr13 <- select(chr13, -1)
chr14 <- select(chr14, -1)

## read in the positional files

pos1 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr1.012.pos", sep="_", header = FALSE)
pos2 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr2.012.pos", sep="_", header = FALSE)
pos3 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr3.012.pos", sep="_", header = FALSE)
pos4 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr4.012.pos", sep="_", header = FALSE)
pos5 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr5.012.pos", sep="_", header = FALSE)
pos6 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr6.012.pos", sep="_", header = FALSE)
pos7 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr7.012.pos", sep="_", header = FALSE)
pos8 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr8.012.pos", sep="_", header = FALSE)
pos9 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr9.012.pos", sep="_", header = FALSE)
pos10 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr10.012.pos", sep="_", header = FALSE)
pos11 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr11.012.pos", sep="_", header = FALSE)
pos12 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr12.012.pos", sep="_", header = FALSE)
pos13 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr13.012.pos", sep="_", header = FALSE)
pos14 <- read.delim("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr14.012.pos", sep="_", header = FALSE)


#format the position files
pos1 <- as.data.frame(sub("\t", "_", pos1$V2, fixed = TRUE))
pos2 <- as.data.frame(sub("\t", "_", pos2$V2, fixed = TRUE))
pos3 <- as.data.frame(sub("\t", "_", pos3$V2, fixed = TRUE))
pos4 <- as.data.frame(sub("\t", "_", pos4$V2, fixed = TRUE))
pos5 <- as.data.frame(sub("\t", "_", pos5$V2, fixed = TRUE))
pos6 <- as.data.frame(sub("\t", "_", pos6$V2, fixed = TRUE))
pos7 <- as.data.frame(sub("\t", "_", pos7$V2, fixed = TRUE))
pos8 <- as.data.frame(sub("\t", "_", pos8$V2, fixed = TRUE))
pos9 <- as.data.frame(sub("\t", "_", pos9$V2, fixed = TRUE))
pos10 <- as.data.frame(sub("\t", "_", pos10$V2, fixed = TRUE))
pos11 <- as.data.frame(sub("\t", "_", pos11$V2, fixed = TRUE))
pos12 <- as.data.frame(sub("\t", "_", pos12$V2, fixed = TRUE))
pos13 <- as.data.frame(sub("\t", "_", pos13$V2, fixed = TRUE))
pos14 <- as.data.frame(sub("\t", "_", pos14$V2, fixed = TRUE))

colnames(pos1) <- "pos"
colnames(pos2) <- "pos"
colnames(pos3) <- "pos"
colnames(pos4) <- "pos"
colnames(pos5) <- "pos"
colnames(pos6) <- "pos"
colnames(pos7) <- "pos"
colnames(pos8) <- "pos"
colnames(pos9) <- "pos"
colnames(pos10) <- "pos"
colnames(pos11) <- "pos"
colnames(pos12) <- "pos"
colnames(pos13) <- "pos"
colnames(pos14) <- "pos"


## combine the pos files
all_pos <- rbind(pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8, pos9, pos10, pos11, pos12, pos13, pos14)
dim(all_pos)

## read in the individual file. only one is needed here

indv <- read.csv("~/Documents/UMontana/Research/YNP/AHQsd/AHQsd_chr1.012.indv", header = FALSE)

## format the position file 

indv <- select(indv, V1)
## name the column
colnames(indv) <- "ind"
## combine the chromosomes 


all_chr <- cbind(chr1, chr2, chr3, chr4, chr5, chr6, chr7, chr8, chr9, chr10, chr11, chr12, chr13, chr14)
rownames(all_chr) = indv$ind
colnames(all_chr) = all_pos$pos

rownames(all_chr) 
## write the .csv
write_csv(all_chr, "AHQsd_F2_genotypes_raw.csv")
