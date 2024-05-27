# GWAS and Haploreg Analysis

### Project Overview

This project involves the analysis of GWAS catalog data and transcription binding sites using R. The scripts are designed to download GWAS catalog data and analyze transcription binding sites. The project was developed using RStudio version 4.2.0.

### Author
**Name:** Simranjit Kaur Kang

**Date:** May 6, 2022

### Description

1. **GWASrapidd.R**: This script is used to download GWAS catalog data.
2. **Hapolo.R**: This script is used to analyze the transcription binding site.

### Required Files
- `extdata/snps.txt`
- `GWASrapidd.R`
- `haploR.R`

### Required Software
- RStudio version 4.2.0

### Required Packages
- `gwasrapidd`
- `haploR`
- `dplyr`
- `tidyr`
- `openxlsx`
- `httr`

### Execution Instructions

1. **Open RStudio.**
2. **Set the working directory to the project folder.**
   ```R
   setwd('~/path/to/project')
   ```
3. **Run the GWASrapidd.R script:**

   ```R
   library(gwasrapidd)
   my_studies <- get_studies(efo_trait = 'urinary bladder carcinoma')
   gwasrapidd::n(my_studies)
   my_studies@studies$study_id
   my_studies@publications$title
   my_associations <- get_associations(study_id = my_studies@studies$study_id)
   gwasrapidd::n(my_associations)
   dplyr::filter(my_associations@associations, pvalue < 1e-6) %>%
     tidyr::drop_na(pvalue) %>%
     dplyr::pull(association_id) -> association_ids
   my_associations2 <- my_associations[association_ids]
   gwasrapidd::n(my_associations2)
   sink("./GWASVariants.txt", append = TRUE)
   my_associations2@risk_alleles[c('variant_id', 'risk_allele')]
   sink()
   ```

4. **Run the Hapolo.R script:**

   ```R
   library(haploR)
   setwd('~/Desktop/PROJECT')
   x <- queryHaploreg(file = system.file("extdata/snps.txt", package = "haploR"))
   if (length(x) != 0) {
     subset.high.LD <- x[as.numeric(x$r2) > 0.9, c("rsID", "r2", "chr", "pos_hg38", "is_query_snp", "ref", "alt")]
     require(openxlsx)
     write.xlsx(x = subset.high.LD, file = "subset.high.LD.xlsx")
     motif <- x[, c("Motifs", "rsID")]
     eQTL <- x[, c("eQTL", "rsID")]
     write.xlsx(x = motif, file = "motif.xlsx")
     write.xlsx(x = eQTL, file = "eQTL.xlsx")
   }
   ```

5. **Run individual SNP extended views:**

   ```R
   sink("./rs2976388.txt", append = TRUE)
   SNIP1 <- getExtendedView(snp = "rs2976388")
   SNIP1
   sink()

   sink("./rs3752645.txt", append = TRUE)
   SNIP2 <- getExtendedView(snp = "rs3752645")
   SNIP2
   sink()

   sink("./rs6104690.txt", append = TRUE)
   SNIP3 <- getExtendedView(snp = "rs6104690")
   SNIP3
   sink()

   sink("./rs7238033.txt", append = TRUE)
   SNIP4 <- getExtendedView(snp = "rs7238033")
   SNIP4
   sink()

   sink("./rs798766.txt", append = TRUE)
   SNIP5 <- getExtendedView(snp = "rs798766")
   SNIP5
   sink()

   sink("./rs907612.txt", append = TRUE)
   SNIP6 <- getExtendedView(snp = "rs907612")
   SNIP6
   sink()
   ```

6. **Run Regulome query:**

   ```R
   queryRegulome(query = c("rs2976388, rs3752645, rs6104690, rs7238033, rs798766, rs907612"), encoding = "UTF-8", verbose = FALSE, limit = 1000, timeout = 100)
   ```

### Notes
- Ensure all required packages are installed in your R environment before executing the scripts.
- Adjust the working directory paths as necessary to fit your local environment setup.

This project showcases the integration of various bioinformatics tools and methodologies to analyze GWAS data and transcription binding sites, providing insights into genetic associations and regulatory elements.
