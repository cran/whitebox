## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 6,
  fig.height = 6 
)

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

# R package dataset symbol names
wbttools <- NULL
wbttoolparameters <- NULL

data("wbttools", package = "whitebox")

## -----------------------------------------------------------------------------
data("wbttools", package = "whitebox")

str(wbttools)

## -----------------------------------------------------------------------------
head(wbttools)

## -----------------------------------------------------------------------------
data("wbttoolparameters", package = "whitebox")

## -----------------------------------------------------------------------------
head(wbttoolparameters)

## -----------------------------------------------------------------------------
str(wbttoolparameters, max.level = 1)

## -----------------------------------------------------------------------------
head(subset(wbttoolparameters, grepl("ExistingFile", parameter_class) & grepl("Raster", parameter_detail)))

## ----echo=FALSE, results='asis'-----------------------------------------------
# hide this, we add the parentheses for the docs
wbttoolsshow <- wbttools
wbttoolsshow$function_name <- paste0("`", wbttoolsshow$function_name, "()`")
wbttoolssplt <- split(wbttoolsshow[,colnames(wbttoolsshow) %in% c("function_name", "description")],
                      list(wbttoolsshow$toolbox_name))

if (requireNamespace("knitr")) {
  x <- sapply(names(wbttoolssplt), function(nm) {
    cat("###", nm, "\n\n")
    print(knitr::kable(
      wbttoolssplt[[nm]],
      caption = paste("Toolbox:", nm),
      col.names = c("Function Name",  "Description"),
      row.names = FALSE
    ))
  })
}

