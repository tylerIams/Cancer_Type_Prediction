---
  title: "Iams_Tyler_EDA"
author: "Tyler Iams"
date: "5/6/2018"
output: html_document
---
  
  ```{r, message=FALSE}
library(tidyverse)
library(knitr)
```

## Read in Data 

```{r}
# Reader Function
reader <- function (i, j, k) {
  dat <- read_csv(str_c("data/", j, "_files/file", i, ".csv"))
  dat <- dat %>% select(-cancer_type_1, -cancer_type_2)
  dat <- dat %>% mutate(gene = sapply(str_split(dat$gene, ":"), "[", 2)) 
  dat <- dat %>% mutate(gene = str_replace_all(dat$gene, "\"", ""),
                        gene = trimws(gene))
  dat <- dat %>% mutate(genomic_dna_change = 
                          sapply(str_split(dat$genomic_dna_change, "\"genomic_dna_change\":"), "[", 2),
                        genomic_dna_change = trimws(genomic_dna_change)) 
  dat <- dat %>% mutate(genomic_dna_change = str_replace_all(dat$genomic_dna_change, "\"", ""))
  dat <- dat %>% mutate(chromosome = sapply(strsplit(dat$genomic_dna_change, ":"), "[", 1),
                        chromosome = trimws(chromosome))
  dat <- dat %>% mutate(case = k)
}
```

```{r, message=FALSE, warning=FALSE}
# Call the function to read in all the files

dat <- tibble(case = NA, cancer_type = NA, gene = NA, genomic_dna_change = NA, chromosome = NA)

for (j in c("lung", "brain", "kidney", "leukemia")) {
  for (i in 1:100) {
    k <- str_c(j, "_", i)
    tempfile <- reader(i, j, k)
    dat <- rbind(dat, tempfile) %>% na.omit()
  }
}

write_csv(dat, "data/EDA_data.csv")
```

## If data has already been read in, use this:

```{r}
# Once the data has been read in, use this:

dat <- read_csv("data/EDA_data.csv")
```

```{r}
# Get a general idea of the data structure

table01 <- dat %>% count(cancer_type) %>% kable(col.names = c("primary_site", "num_cases"), align = "r")

plot01 <- dat %>% ggplot(aes(x = cancer_type)) + geom_bar(aes(color = cancer_type))

table01

plot01
```

```{r}
# Look at most common mutations by cancer type

table02 <- dat %>% select(-genomic_dna_change) %>% unique() %>% group_by(cancer_type) %>% count(gene) %>% arrange(desc(n)) %>% filter(n >= 50) 

table02 %>% ggplot(aes(x = gene, y = n, color = cancer_type)) + geom_col()

table02
# Looks like we need to look at proportional prevalence
```

```{r}

dat02 <- dat %>% select(-genomic_dna_change) %>% unique()

dat02 %>% count(cancer_type)

dat02 <- dat02 %>% mutate(occurrances = ifelse(cancer_type == "brain", 66596,
                                               ifelse(cancer_type == "kidney", 17457,
                                                      ifelse(cancer_type == "leukemia", 10320,
                                                             ifelse(cancer_type == "lung", 114409, NA)))))

dat03 <- dat02 %>% group_by(cancer_type, occurrances) %>% count(gene) %>% mutate(proportion = (n/occurrances)*100) 

dat03 <- dat03 %>% ungroup(cancer_type, occurances) %>% select(cancer_type, gene, proportion) %>% arrange(desc(proportion))
```

```{r}
x <- 0
y <- 0
dat04 <- tibble(gene = NA, type1type2 = NA, ratio = NA)
for (i in dat03$gene[1:10000]) {
  x <- x + 1
  y <- 0
  for (j in dat03$gene[1:10000]) {
    y <- y + 1
    if (i == j & y != x) {
      temp = tibble(gene = i, type1type2 = str_c(dat03$cancer_type[x], "/", dat03$cancer_type[y]), ratio = dat03$proportion[x]/dat03$proportion[y])
      dat04 <- rbind(dat04, temp) %>% na.omit()
    } 
  }
}

# This shows me the ratios at which mutations occur in different types of cancer

dat04 %>% filter(ratio >= 1) %>% arrange(desc(ratio))
```

```{r}

# Try to make some mutation profiles

genes_vec <- dat %>% select(gene) %>% unique()
case_vec <- dat %>% select(case) %>% unique()

genes_vec <- as.vector(genes_vec)


tibby <- tibble(gene = NA, case = NA)
join <- tibble(gene = genes_vec$gene[1:10], case = 1:10)

for (i in case_vec$case[1:10]) {
  x <- 0
  join <- full_join(join, tibby, by = "gene")
  for (j in genes_vec$gene[1:10]) {
    x <- x + 1
    print(str_c(x, " ", i, " ", j))
    temp <- tibble(gene = j, case = i)
    tibby <- rbind(tibby, temp) %>% na.omit()
  }
}

matrix <- matrix(nrow = 19670, ncol = 400)

for (i in 1:400) {
  case <- case_vec$case[i]
  for (i in 1:19670) {
    gene <- genes_vec$gene[i]
  }
}
case_vec$case[1]
matrix[1,1]
```