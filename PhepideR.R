library(dplyr)

PhepideR = function(chromosome = "9",
                    hg19_position = "139391338",
                    ref = "C",
                    alt = "T"){
  
  snp_name = paste0(chromosome, ":", hg19_position,"-", ref, "-", alt)
  ukb_saige_url = paste0("https://pheweb.org/UKB-SAIGE/variant/", snp_name)
  
  parse_file = function(url){
    suppressWarnings({
      try({
        download.file(url = url, destfile = "tempfile")
        stat_file = readLines("tempfile")
        
        for(l in stat_file){
          if(grepl("window.variant", l)){
            stat_table = l
          }
        }
        
        meta_stat = unlist(strsplit(stat_table, split = "\"phenos\""))[1]
        meta_stat = gsub("window.variant", "", meta_stat)
        meta_stat = gsub("=", "", meta_stat)
        meta_stat = gsub("\"", "", meta_stat)
        meta_stat = gsub(" ", "", meta_stat)
        meta_stat = unlist(strsplit(meta_stat, split = ","))
        
        consequence = meta_stat[grepl("consequence:", meta_stat)]
        consequence = gsub("consequence:","", consequence)
        
        nearest_genes = meta_stat[grepl("nearest_genes:", meta_stat)]
        nearest_genes = gsub("nearest_genes:","", nearest_genes)
        
        meta_table = tibble(consequence, nearest_genes)
        
        pheno_stat = unlist(strsplit(stat_table, split = "\"phenos\""))[2]
        pheno_stat = gsub("\"", "", pheno_stat)
        pheno_stat = unlist(strsplit(pheno_stat, ","))
        
        hits = vector()
        for(p in 1:length(pheno_stat)){
          if(grepl("ac:", pheno_stat[p])){
            ac = unlist(strsplit(pheno_stat[p], split = ":"))
            ac = ac[length(ac)]
            
            af = unlist(strsplit(pheno_stat[p+1], split = ":"))
            af = af[length(af)] 
            
            beta = unlist(strsplit(pheno_stat[p+2], split = ":"))
            beta = beta[length(beta)] 
            
            category = unlist(strsplit(pheno_stat[p+3], split = ":"))
            category = category[length(category)] 
            
            num_cases = unlist(strsplit(pheno_stat[p+4], split = ":"))
            num_cases = num_cases[length(num_cases)] 
            
            num_controls = unlist(strsplit(pheno_stat[p+5], split = ":"))
            num_controls = num_controls[length(num_controls)] 
            
            phenocode = unlist(strsplit(pheno_stat[p+6], split = ":"))
            phenocode = phenocode[length(phenocode)] 
            
            phenostring = unlist(strsplit(pheno_stat[p+7], split = ":"))
            phenostring = phenostring[length(phenostring)] 
            
            pval = unlist(strsplit(pheno_stat[p+8], split = ":"))
            pval = pval[length(pval)] 
            
            sebeta = unlist(strsplit(pheno_stat[p+9], split = ":"))
            sebeta = sebeta[length(sebeta)] 
            
            trait_is_bad = unlist(strsplit(pheno_stat[p+10], split = ":"))
            trait_is_bad = trait_is_bad[length(trait_is_bad)] 
            
            tstat = unlist(strsplit(pheno_stat[p+11], split = ":"))
            tstat = tstat[length(tstat)] 
            
            hit = tibble(ac, af, beta, category, num_cases, num_controls,
                         phenocode, phenostring, pval, sebeta, trait_is_bad, tstat)
            hits = rbind.data.frame(hits, hit)
            
          }
        }
        
        hits = hits %>%
          mutate(pval = as.numeric(pval)) %>%
          arrange(pval) %>%
          filter(trait_is_bad=="false")
        
        file.remove("tempfile")
        
        return(list(
          meta = meta_table,
          hits = hits
        ))
        
      }, silent = TRUE)
    })
  }
  
  result = parse_file(url = ukb_saige_url)
  return(result)
  
}

# Run
# PhepideR()














