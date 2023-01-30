library(gwasrapidd)
print(my_studies)
my_studies <- get_studies(efo_trait = 'urinary bladder carcinoma')
gwasrapidd::n(my_studies)
my_studies@studies$study_id
my_studies@publications$title
my_associations <- get_associations(study_id = my_studies@studies$study_id)
gwasrapidd::n(my_associations)
# Get association ids for which pvalue is less than 1e-6.
dplyr::filter(my_associations@associations, pvalue < 1e-6) %>% # Filter by p-value
  tidyr::drop_na(pvalue) %>%
  dplyr::pull(association_id) -> association_ids # Extract column association_id
# Extract associations by association id
my_associations2 <- my_associations[association_ids]
gwasrapidd::n(my_associations2)
sink("./GWASVariants.txt",append=T)
my_associations2@risk_alleles[c('variant_id', 'risk_allele')]
sink()
