# Session 2 - Introduction and Data Transformation

For this session:
  1. We will review over the dplyr verbs we learned in session 1:
      * `filter()`
      * `arrange()`
      * `select()` and `rename()`
        * `select()` adverbs: `starts_with()`, `ends_with()`, `contains()`, and others
      * `mutate()` and `transmute()`

  2. We will go over grouping observations using `group_by()` and summarising (spelling is intentional) by groups using `summarise()`.

  3. We will go over how to use the pipe (`%>%`) for cleaner code.

  4. We will go over basic reading and writing files using various functions:
      * CSV: `write_csv()` and `read_csv()`
      * Excel files: `read_excel()` from the [readxl](http://readxl.tidyverse.org/) package (part of the tidyverse suite but not loaded with tidyverse).
      * RData: `save()`, `save.image()`, and `load()`
      * RDS: `write_rds()` and `read_rds()`

  5. We will introduce data types and parsing.

This session corresponds to the following sections of the [R for Data Science](http://r4ds.had.co.nz/transform.html) text:
* [5.6 Grouped summaries with `summarise()`](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise)
* [5.7 Grouped mutates (and filters)](http://r4ds.had.co.nz/transform.html#grouped-mutates-and-filters)
* [6 Workflow: scripts](http://r4ds.had.co.nz/workflow-scripts.html)
* [8 Workflow: projects](http://r4ds.had.co.nz/workflow-projects.html)
* [9 Wrangle Introduction](http://r4ds.had.co.nz/wrangle-intro.html)
* [10 Tibbles](http://r4ds.had.co.nz/tibbles.html)
* [11 Data import](http://r4ds.had.co.nz/data-import.html)

We will constantly be using the dplyr verbs and in the future we will learn how to apply some verbs across multiple columns using functions such as `mutate_if()`, `rename_all()`, and `summarise_at()`.
