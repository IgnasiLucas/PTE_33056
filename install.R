install.packages('phangorn')
install.packages('learnPopGen')
install.packages('pegas')
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DECIPHER")

