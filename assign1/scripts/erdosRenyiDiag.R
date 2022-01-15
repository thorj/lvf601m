set.seed(1)
# Initialize variables for simulation
# L (iterations), n (nodes), k (edges)
L <- c(100, 1000, 10000, 100000)
n <- 400
k <- 500
l <- length(L)

# Initialize a results data frame
res <- data.frame(Iteration = 1:l, 
                  Simulations = L, 
                  Mean = 0, 
                  SD = 0, 
                  Time = 0)

# Iterate for each element of L and store results
for (i in 1:l) {
    start <- Sys.time()
    sim <- replicate(L[i], rbinom(1, k, p = 1/n))
    
    res[i, 3] <- mean(sim)
    res[i, 4] <- sd(sim)
    
    stops <- Sys.time() - start
    res[i, 5] <- stops[[1]]
}

path <- here('tables', 'erdDiaTab.txt')

# Write results to table and export
write.table(x = res, file = path, sep = ';', 
            quote = F, row.names = F)
