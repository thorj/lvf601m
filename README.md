# LVF601M: Introduction to systems biology
This is a repository to store my solutions to the homework handed out in LVF601M.

## Structure
Folders `assign{x}`, where _x_ is a wildcard, contain my solutions to assignment _x_.

The folder structure of each `assign{x}` is (currently) as follows:

```
bib/            Bibliography
renv/           R environment [locked]
report/         Final result [.Rmd, .pdf]
scripts/        Scripts for final result
tables/         Tables for final results
img/            Images for final result
Snakefile       Workflow file
workflow.svg    Flowchart of dependencies/workflow
```

## Relative paths
You need to clone the entire repository! The code relies on the `here()` function which uses heuristics to determine the project root folder. Without the root all relative paths will be broken.
