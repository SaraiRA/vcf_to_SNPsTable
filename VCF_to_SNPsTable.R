
vcf <- read.table("~/.vcf", header =T, sep ='',stringsAsFactors=FALSE)

# Building table with the alleles for each sample
vcf_samples <- vcf[,-c(3,6,7,8,9)]
for(i in 1: dim(vcf_samples)[1]){
  for (j in 5:dim(vcf_samples)[2]){
      if(as.character ( strsplit(as.character(vcf_samples[i,j]), split = ":")[[1]][1])=="0"){
        vcf_samples[i,j] <- as.character(vcf_samples[i,3])
    } else if (as.character( strsplit(as.character(vcf_samples[i,j]), split = ":")[[1]][1])=="1") {
        vcf_samples[i,j] <- strsplit(as.character(vcf_samples[i,4]), split = ",")[[1]][1]
    } else if (as.character( strsplit(as.character(vcf_samples[i,j]), split = ":")[[1]][1])=="2") {
        print(vcf_samples[i,1])
        if (strsplit(as.character(vcf_samples[i,4]), split = ",")[[1]][2]=="*"){
          vcf_samples[i,j] <- NA
        }else{
          vcf_samples[i,j] <- strsplit(as.character(vcf_samples[i,4]), split = ",")[[1]][2]
        }
    } else if (as.character (strsplit(as.character(vcf_samples[i,j]), split = ":")[[1]][1])=="."){
        vcf_samples[i,j] <- NA
    }
  }
}

vcf_samples_NOT_na<-na.omit(vcf_samples)

# Output in excel 
write.table(vcf_samples_NOT_na, "~/table_alleles_eachsample.txt", sep="\t", row.names =TRUE )
