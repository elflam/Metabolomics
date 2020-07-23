###merge two files by column without identical rownames
###Emily Flam
###7.22.2020

#dataframes to merge are called "first" and "second"
setwd("C:/Users/Emily/Desktop/Box Sync/Data/Human HF cohort/raw metabolomics data and pipeline inputs/")

first <- read.csv("C:/Users/Emily/Desktop/Box Sync/Data/Human HF cohort/raw metabolomics data and pipeline inputs/tissue/tissue batch 1 OA and filtered and normalized redundants removed.csv", header=TRUE, sep=",",quote="",na.strings="", comment.char="", stringsAsFactors = FALSE)
rownames(first) <- trimws(tolower(first[,1]),whitespace=" ")
first <- first[,-1]
  
second <- read.csv("C:/Users/Emily/Desktop/Box Sync/Data/Human HF cohort/raw metabolomics data and pipeline inputs/tissue/Tissue batch 2 OA and filtered and normalized redundants removed.csv", header=TRUE, sep=",",quote="",na.strings="", comment.char="", stringsAsFactors = FALSE)
rownames(second) <- trimws(tolower(second[,1]),whitespace=" ")
second <- second[,-1]

#make vectors of rows that are in the first but not the second and vice versa
diffOne <- setdiff(rownames(first), rownames(second))
diffTwo <- setdiff(rownames(second), rownames(first))

#add rows to the first file with missing rows from the second
for (i in diffTwo){
  first <- rbind(first,c(rep(NA,ncol(first))))
  rownames(first)[nrow(first)] <- i
}

#add missing rows to the second file
for (i in diffOne){
  second <- rbind(second,c(rep(NA,ncol(first))))
  rownames(second)[nrow(second)] <- i
}

#merge the two files
total <- cbind(first,second)
total <- total[sort(rownames(total)),]

#save file
write.csv(total, file="C:/Users/Emily/Desktop/Box Sync/Data/Human HF cohort/raw metabolomics data and pipeline inputs/tissue/all tissue OA and filtered and normalized.csv") 
