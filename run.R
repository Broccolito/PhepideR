get_directory = function(){
  args <- commandArgs(trailingOnly = FALSE)
  file <- "--file="
  rstudio <- "RStudio"
  match <- grep(rstudio, args)
  if(length(match) > 0){
    return(dirname(rstudioapi::getSourceEditorContext()$path))
  }else{
    match <- grep(file, args)
    if (length(match) > 0) {
      return(dirname(normalizePath(sub(file, "", args[match]))))
    }else{
      return(dirname(normalizePath(sys.frames()[[1]]$ofile)))
    }
  }
}

setwd(get_directory())

source("PhepideR.R")

notch1 = PhepideR(chromosome = "9",
                  hg19_position = "139391338",
                  ref = "C",
                  alt = "T")

fbn1 = PhepideR(chromosome = "15",
                hg19_position = "48773926",
                ref = "T",
                alt = "C")

eid1 = PhepideR(chromosome = "15",
                hg19_position = "49237558",
                ref = "C",
                alt = "T")
