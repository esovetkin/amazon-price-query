install <- function(package)
  if (!require(package,character.only=TRUE))
    install.packages(package,
                     repos="https://cloud.r-project.org")

lapply(c("ggplot2","gridExtra"),install)
