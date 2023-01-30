library(haploR)
setwd('~/Desktop/PROJECT')

x <- queryHaploreg(file=system.file("extdata/snps.txt", package = "haploR"))
x
if(length(x)!=0) {
  subset.high.LD <- x[as.numeric(x$r2) > 0.9, c("rsID", "r2", "chr", "pos_hg38", "is_query_snp", "ref", "alt")]
  subset.high.LD
}
require(openxlsx)
write.xlsx(x=subset.high.LD, file="subset.high.LD.xlsx")
if(length(x)!=0) {
 motif <- x[, c("Motifs", "rsID")]
  eQTL <- x[, c("eQTL", "rsID")]
}
require(openxlsx)
write.xlsx(x=motif, file="motif.xlsx")
write.xlsx(x=eQTL, file="eQTL.xlsx")

sink("./rs2976388.txt",append=T)
SNIP1 <- getExtendedView(snp="rs2976388")
SNIP1
sink()

sink("./rs3752645.txt",append=T)
SNIP2 <- getExtendedView(snp="rs3752645")
SNIP2
sink()

sink("./rs6104690.txt",append=T)
SNIP3 <- getExtendedView(snp="rs6104690")
SNIP3
sink()

sink("./rs7238033txt",append=T)
SNIP3 <- getExtendedView(snp="rs7238033")
SNIP3
sink()

sink("./rs798766.txt",append=T)
SNIP4 <- getExtendedView(snp="rs798766")
SNIP4
sink()

sink("./rs907612.txt",append=T)
SNIP5 <- getExtendedView(snp="rs907612")
SNIP5
sink()

queryRegulome(query = c("rs2976388,rs3752645,rs6104690,rs7238033,rs798766,rs907612"), encoding = "UTF-8", verbose = FALSE,
              limit = 1000,
              timeout = 100)
library(httr)

x<- (queryRegulome(c("rs2976388")))

