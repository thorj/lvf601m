# Function to initialize an empty adjacency matrix
genMatrix <- function(n) {
        emptyMatrix <- matrix(0, nrow = n, ncol = n)       
}

# Naive function to generate an Erdos-Renyi graph
# by populating an adjacency matrix for some 
# graph with n nodes until k edges have been
# formed. 
populateMatrix <- function(n, k) {
        adjMatrix <- genMatrix(n)
        cnt <- 0
        while(cnt < k) {
                row <- sample(1:n, size = 1)
                col <- sample(1:n, size = 1)
                if (adjMatrix[row, col] == 0) {
                        adjMatrix[row, col] <- 1
                }
                cnt <- sum(adjMatrix)
        }
        return(adjMatrix)
}

# Function to count number of self arrows by
# computing the trace of the adjacency matrix
selfArrowsSum <- function(adjMatrix) {
        return(sum(diag(adjMatrix)))
}

# Function to compute the theoretical mean, 
# theoretical standard deviation, simulated 
# sample mean, simulated unbiased and biased 
# sample standard deviation.  
summaryStatistics <- function(data, n, k) {
        theoreticalMean <- k/n
        theoreticalSD <- sqrt(k/n)
        simulatedMean <- mean(data)
        simulatedUnbiasedSD <- sd(data)
        simulatedBiasedSD <- sd(data) * sqrt((n - 1) / n)
        return(list(theoreticalMean = theoreticalMean, 
                    theoreticalSD = theoreticalSD,
                    simulatedMean = simulatedMean, 
                    simulatedUnbiasedSD = simulatedUnbiasedSD,
                    simulatedBiasedSD = simulatedBiasedSD))
}

#################
### Test case ###
#################

# Seed for reproducibility
set.seed(1)

# Define nodes (n), arrows (k) and number of iterations (L)
n <- 400
k <- 500
L <- 100

# Initialize output data frame and iterate
# Store computational time for comparison
info <- data.frame(it = 1:L, sum = 0)

start <- Sys.time()
for (i in 1:L) {
        erdosRenyi <- populateMatrix(n, k)
        info[i, 2] <- selfArrowsSum(erdosRenyi)
}
stop <- Sys.time() - start
stop <- stop[[1]]

# Get results and export as table
res <- summaryStatistics(info$sum, n, k)
export <- 
    data.frame(Type = c('Theoretical mean',
                        'Theoretical SD',
                        'Simulation mean',
                        'Simulation SD [unbiased]',
                        'Simulation SD [biased]',
                        'Computational time'), 
               Value = c(unlist(res), stop))


path <- here('assign1', 'tables', 'erdNavTab.txt')
write.table(x = export, file = path, quote = F, 
            sep = ';', row.names = F)




