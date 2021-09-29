# PhepideR
Query Genotype-Phenotype Association statistics from the UK Biobank Dataset



### Usage

Edit ```run.R``` file, adding the dbSNP id of the variant of interest. An Example ```run.R``` file looks like:

```R
# Make sure to source the PhepideR function
source("PhepideR.R")

notch1 = PhepideR(chromosome = "9",
                  hg19_position = "139391338",
                  ref = "C",
                  alt = "T")
```



An example output looks like:

```text
$meta
# A tibble: 1 x 2
  consequence      nearest_genes
  <chr>            <chr>        
1 missense_variant NOTCH1       

$hits
# A tibble: 1,128 x 12
   ac      af    beta  category   num_cases num_controls phenocode phenostring            pval sebeta trait_is_bad tstat
   <chr>   <chr> <chr> <chr>      <chr>     <chr>        <chr>     <chr>                 <dbl> <chr>  <chr>        <chr>
 1 13475.3 0.017 2.6   endocrine~ 103       405386       255.11    "Cushing\\u0027s sy~ 1.1e-4 0.67   false        0.073
 2 13175.1 0.017 0.56  neurologi~ 1112      395209       331       "Other cerebral deg~ 1.1e-3 0.17   false        0.17 
 3 11171.7 0.017 -0.44 digestive  1650      334783       564.8     "Abnormal findings ~ 1.6e-3 0.14   false        -0.22
 4 13505.1 0.017 0.65  endocrine~ 781       405386       252.1     "Hyperparathyroidis~ 1.7e-3 0.21   false        0.14 
 5 13568.0 0.017 -0.25 sense org~ 4611      402827       386.9     "Dizziness and gidd~ 2.8e-3 0.083  false        -0.31
 6 13124.1 0.017 0.74  infectiou~ 492       393897       038.2     "Gram positive sept~ 4  e-3 0.26   false        0.1  
 7 13545.4 0.017 1.3   infectiou~ 163       406301       117.4     "Aspergillosis"      4.9e-3 0.46   false        0.058
 8 13563.4 0.017 1.2   symptoms   175       407145       782.6     "Pallor and flushin~ 5.5e-3 0.44   false        0.059
 9 13394.7 0.017 -0.62 digestive  617       401525       531.1     "Hemorrhage from ga~ 6.2e-3 0.23   false        -0.11
10 13597.1 0.017 0.52  neoplasms  876       407399       227       "Benign neoplasm of~ 6.4e-3 0.19   false        0.12 
# ... with 1,118 more rows
```

```$meta``` refers to the variant type and nearest gene(s), and ```$hits``` refers to all the significant regression hits that this variant.



### Reference

Gagliano Taliun, S.A., VandeHaar, P. et al. Exploring and visualizing large-scale genetic associations by using PheWeb. *Nat Genet* 52, 550–552 (2020).

Taliun, Daniel, Daniel N. Harris, Michael D. Kessler, Jedidiah Carlson, Zachary A. Szpiech, Raul Torres, Sarah A. Gagliano Taliun, et al. 2021. “Sequencing of 53,831 Diverse Genomes from the NHLBI TOPMed Program.” *Nature* 590 (7845): 290–99.









