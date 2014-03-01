### R code from vignette source 'BaSTAoverview.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: setup
###################################################
library(BaSTA)
data("sim1", package = "BaSTA")
data("sim1Out", package = "BaSTA")


###################################################
### code chunk number 2: BaSTAoverview.Rnw:85-92
###################################################
id.vec     <- sort(c(rep(1, 3), rep(2, 3), rep(3, 2), rep(4, 3), rep(5, 2)))
d.vec       <- c(c(1990, 1992, 1993), c(1991, 1992, 1994), 
                 c(1992, 1993),
                 c(1991, 1992, 1995), c(1993, 1995))

censusMat <- cbind(id.vec, d.vec)
colnames(censusMat) <- c("ID", "Year")


###################################################
### code chunk number 3: BaSTAoverview.Rnw:97-99 (eval = FALSE)
###################################################
## censusMat <- read.table("location of census table.txt", 
##                         sep = "\t", header = TRUE)


###################################################
### code chunk number 4: BaSTAoverview.Rnw:102-103 (eval = FALSE)
###################################################
## censusMat <- read.csv("location of census table.csv", header = TRUE)


###################################################
### code chunk number 5: BaSTAoverview.Rnw:106-107
###################################################
head(censusMat)


###################################################
### code chunk number 6: BaSTAoverview.Rnw:111-112
###################################################
Y <- CensusToCaptHist(ID = censusMat[, 1], d = censusMat[, 2])


###################################################
### code chunk number 7: BaSTAoverview.Rnw:119-120
###################################################
print(Y)


###################################################
### code chunk number 8: BaSTAoverview.Rnw:126-130
###################################################
ID <- 1:5
Birth <- c(0, 1990, 1991, 0, 0)
Death <- c(1995, 0, 1994, 0, 0)
birthDeath <- cbind(ID, Birth, Death)


###################################################
### code chunk number 9: BaSTAoverview.Rnw:132-133
###################################################
print(birthDeath)


###################################################
### code chunk number 10: BaSTAoverview.Rnw:142-146
###################################################
sex        <- c("f", "f", "m", "f", "m")
weight     <- rnorm(5, mean = 10, sd = 1)
ID         <- 1:5
rawCovMat  <- data.frame(ID, sex, weight)


###################################################
### code chunk number 11: BaSTAoverview.Rnw:148-149
###################################################
print(rawCovMat)


###################################################
### code chunk number 12: BaSTAoverview.Rnw:154-155
###################################################
covMat <- MakeCovMat(x = c("sex", "weight"), data = rawCovMat)


###################################################
### code chunk number 13: BaSTAoverview.Rnw:160-161
###################################################
print(covMat)


###################################################
### code chunk number 14: BaSTAoverview.Rnw:166-167
###################################################
covMat <- MakeCovMat(x = ~ sex + weight + sex:weight, data = rawCovMat)


###################################################
### code chunk number 15: BaSTAoverview.Rnw:171-172
###################################################
print(covMat)


###################################################
### code chunk number 16: BaSTAoverview.Rnw:180-182
###################################################
inputMat <- as.data.frame(cbind(birthDeath, Y[, -1], covMat[, -1]))
print(inputMat)


###################################################
### code chunk number 17: BaSTAoverview.Rnw:187-190
###################################################
inputMat <- merge(birthDeath, Y, by.x = "ID", by.y = "ID")
inputMat <- merge(inputMat, covMat, by.x = "ID", by.y = "ID")
print(inputMat)


###################################################
### code chunk number 18: BaSTAoverview.Rnw:198-201 (eval = FALSE)
###################################################
## newData <- DataCheck(inputMat, studyStart = 1990,
##                      studyEnd = 1995, autofix = rep(1, 7),
##                      silent = FALSE)


###################################################
### code chunk number 19: BaSTAoverview.Rnw:205-208
###################################################
newData <- DataCheck(object = inputMat, studyStart = 1990,
                     studyEnd = 1995, autofix = rep(1, 7),
                     silent = FALSE)


###################################################
### code chunk number 20: BaSTAoverview.Rnw:235-239
###################################################
inputMatErr  <- inputMat
inputMatErr[3, 2] <- 1991
inputMatErr[3, 3] <- 1990
print(inputMatErr[3, ])


###################################################
### code chunk number 21: BaSTAoverview.Rnw:243-245
###################################################
newData <- DataCheck(inputMatErr, studyStart = 1990,
                     studyEnd = 1995, autofix = rep(1,7), silent = TRUE)


###################################################
### code chunk number 22: BaSTAoverview.Rnw:252-253 (eval = FALSE)
###################################################
## out <- basta(object = inputMat, studyStart = 1990, studyEnd = 1995)


###################################################
### code chunk number 23: BaSTAoverview.Rnw:292-294 (eval = FALSE)
###################################################
## out <- basta(object = inputMat, studyStart = 1990, studyEnd = 1995, 
##              model = "LO", shape = "bathtub")


###################################################
### code chunk number 24: BaSTAoverview.Rnw:302-304 (eval = FALSE)
###################################################
## out <- basta(object = inputMat, studyStart = 1990, studyEnd = 1995, 
##              minAge = 2)


###################################################
### code chunk number 25: BaSTAoverview.Rnw:323-325 (eval = FALSE)
###################################################
## out <- basta(object = inputMat, studyStart = 1990, studyEnd = 1995,
##              covarsStruct = "all.in.mort")


###################################################
### code chunk number 26: BaSTAoverview.Rnw:330-332 (eval = FALSE)
###################################################
## out <- basta(object = inputMat, studyStart = 1990, studyEnd = 1995,
##              recaptTrans = c(1990, 1993))


###################################################
### code chunk number 27: BaSTAoverview.Rnw:340-342 (eval = FALSE)
###################################################
## out <- basta(object = inputMat, studyStart = 1990, studyEnd = 1995,
##              niter = 1000, burnin = 100, thinning = 10)


###################################################
### code chunk number 28: BaSTAoverview.Rnw:353-356 (eval = FALSE)
###################################################
## out <- basta(object = inputMat, studyStart = 1990, 
##              studyEnd = 2000, model = "LO", 
##              shape = "simple", thetaJumps = c(0.1, 0.1, 0.1))


###################################################
### code chunk number 29: BaSTAoverview.Rnw:360-364
###################################################
new.jumps    <- matrix(c(rep(0.1, 3), rep(0.2, 3)), nrow = 2, 
                       ncol = 3, byrow = TRUE, 
                       dimnames = list(c('cov1', 'cov2'), 
                                       paste("b", 0:2, sep="")))


###################################################
### code chunk number 30: BaSTAoverview.Rnw:368-369
###################################################
print(new.jumps)


###################################################
### code chunk number 31: BaSTAoverview.Rnw:373-375 (eval = FALSE)
###################################################
## out <- basta(object = inputMat, studyStart = 1990, studyEnd = 1995, 
##              model = "LO", shape = "simple", thetaJumps = new.jumps)


###################################################
### code chunk number 32: BaSTAoverview.Rnw:381-384 (eval = FALSE)
###################################################
## out <- basta(object = inputMat, studyStart = 1990, studyEnd = 1995, 
##              model = "LO", shape = "simple", nsim = 2, 
##              parallel = TRUE, ncpus = 2, updateJumps = TRUE)


###################################################
### code chunk number 33: BaSTAoverview.Rnw:393-395 (eval = FALSE)
###################################################
## out <- basta(object = inputMat, studyStart = 1990, studyEnd = 1995, 
##              nsim = 4, parallel = TRUE, ncpus = 4)


###################################################
### code chunk number 34: BaSTAoverview.Rnw:406-407
###################################################
summary(sim1Out, digits = 3)


###################################################
### code chunk number 35: BaSTAoverview.Rnw:414-415 (eval = FALSE)
###################################################
## plot(out)


###################################################
### code chunk number 36: BaSTAoverview.Rnw:423-424
###################################################
plot(sim1Out)


###################################################
### code chunk number 37: BaSTAoverview.Rnw:435-436 (eval = FALSE)
###################################################
## plot(out, trace.name = "gamma")


###################################################
### code chunk number 38: BaSTAoverview.Rnw:441-442 (eval = FALSE)
###################################################
## plot(sim1Out, plot.trace = FALSE)


###################################################
### code chunk number 39: BaSTAoverview.Rnw:449-450
###################################################
plot(sim1Out, plot.trace = FALSE)


