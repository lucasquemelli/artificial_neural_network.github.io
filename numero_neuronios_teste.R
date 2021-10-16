## Matriz com limpeza rigida

library(readxl)
dados <- read_excel("R/dadas.xlsx")
View(dados)

dados <- dados[,-c(1)]


## distância estatístia

x <- dados
y <- as.data.frame(mahalanobis(x, colMeans(x), cov(x)))
names(y)[1] = "Distancias"
y$Index = c(1:nrow(y))


alpha = 0.05
df <- ncol(x[,])
limite <- qchisq(1-alpha,df = df)
is_mv_outlier <- ifelse(y$Distancias > limite, "SIM", "NÃO")
x$Outliers <- is_mv_outlier
x = x[x$Outliers == "NÃO",]


x[29] = NULL

dados <- x

# Normalização MinMax
dadosN <- dados
for (i in 1:ncol(dados)) {
  dadosN[,i] <- (dados[,i] - min(dados[,i]))/(max(dados[,i]) -
                                                min(dados[,i]))
}

# Seletividade = FC0619/FI0219
y <- dadosN$FC0619/dadosN$FI0219

dadosN <- cbind(dadosN,y)
dados <- cbind(dados,y)
dadosN <- dadosN[-c(26),]
dados <- dados[-c(26),]

#Partição aleatória dos Dados
set.seed(222)
ind <- sample(2,nrow(dadosN),replace=TRUE,prob=c(0.8,0.2))
training <- dadosN[ind==1,]
testing <- dadosN[ind==2,]

allVars <- colnames(dadosN)
predictorVars <- allVars[!allVars%in%"y"]
predictorVars <- paste(predictorVars,collapse="+")
form <- as.formula(paste("y~",predictorVars,collapse="+"))


library(neuralnet)

L <- 1
for (i in 1:25) {
  

set.seed(333)
n <- neuralnet(formula = form, data = training, hidden = c(i),
               err.fct="sse",linear.output=TRUE,lifesign="full")

print(L)
predictions.train <- compute(n,training[,-ncol(training)])
predictions.test <- compute(n,testing[,-ncol(testing)])
predictions.all <- compute(n,dadosN[,-ncol(dadosN)])
SQtot.train <- sum((training$y-mean(training$y))^2)
SQres.train <- sum((training$y-predictions.train$net.result)^2)
R2.train <- 1-SQres.train/SQtot.train
R2.train
print(R2.train)

predictions.train.unscaled <- predictions.train$net.result*(max(dados$y)-
                                                              min(dados$y))+min(dados$y)
training.unscaled <- training$y*(max(dados$y)-min(dados$y))+min(dados$y)
MSE.train <- sum((training.unscaled-predictions.train.unscaled)^2)/
  nrow(training)
MSE.train
print(MSE.train)


L <- L + 1

}


library(readxl)
neu <- read_excel("R/neu.xlsx")
View(neu)

plot(neu$`n° N`,neu$R², xlab = "Número de neurônios (-)", ylab = "R² (-)",
     main = "R² em função do número de neurônios")

plot(neu$`n° N`, neu$MSE, xlab = "Número de neurônios (-)", ylab = "MSE (-)",
     main = "MSE em função do número de neurônios")






## Matriz com limpeza relaxada

library(readxl)
dados <- read_excel("R/dados.xlsx")
View(dados)

dados <- dados[,-c(1)]


## distância estatístia

x <- dados
y <- as.data.frame(mahalanobis(x, colMeans(x), cov(x)))
names(y)[1] = "Distancias"
y$Index = c(1:nrow(y))


alpha = 0.05
df <- ncol(x[,])
limite <- qchisq(1-alpha,df = df)
is_mv_outlier <- ifelse(y$Distancias > limite, "SIM", "NÃO")
x$Outliers <- is_mv_outlier
x = x[x$Outliers == "NÃO",]


x[29] = NULL

dados <- x

# Normalização MinMax
dadosN <- dados
for (i in 1:ncol(dados)) {
  dadosN[,i] <- (dados[,i] - min(dados[,i]))/(max(dados[,i]) -
                                                min(dados[,i]))
}

# Seletividade = FC0619/FI0219
y <- dadosN$FC0619/dadosN$FI0219

dadosN <- cbind(dadosN,y)
dados <- cbind(dados,y)
dadosN <- dadosN[-c(226),]
dados <- dados[-c(226),]

#Partição aleatória dos Dados
set.seed(222)
ind <- sample(2,nrow(dadosN),replace=TRUE,prob=c(0.8,0.2))
training <- dadosN[ind==1,]
testing <- dadosN[ind==2,]

allVars <- colnames(dadosN)
predictorVars <- allVars[!allVars%in%"y"]
predictorVars <- paste(predictorVars,collapse="+")
form <- as.formula(paste("y~",predictorVars,collapse="+"))


library(neuralnet)

L <- 1
for (i in 1:25) {
  
  
  set.seed(333)
  n <- neuralnet(formula = form, data = training, hidden = c(i),
                 err.fct="sse",linear.output=TRUE,lifesign="full")
  
  print(L)
  predictions.train <- compute(n,training[,-ncol(training)])
  predictions.test <- compute(n,testing[,-ncol(testing)])
  predictions.all <- compute(n,dadosN[,-ncol(dadosN)])
  SQtot.train <- sum((training$y-mean(training$y))^2)
  SQres.train <- sum((training$y-predictions.train$net.result)^2)
  R2.train <- 1-SQres.train/SQtot.train
  R2.train
  print(R2.train)
  
  predictions.train.unscaled <- predictions.train$net.result*(max(dados$y)-
                                                                min(dados$y))+min(dados$y)
  training.unscaled <- training$y*(max(dados$y)-min(dados$y))+min(dados$y)
  MSE.train <- sum((training.unscaled-predictions.train.unscaled)^2)/
    nrow(training)
  MSE.train
  print(MSE.train)
  
  
  L <- L + 1
  
}



library(readxl)
neu <- read_excel("R/neu.xlsx")
View(neu)

plot(neu$`n° N`,neu$R2, xlab = "Número de neurônios (-)", ylab = "R² (-)",
     main = "R² em função do número de neurônios")

plot(neu$`n° N`, neu$MSE2, xlab = "Número de neurônios (-)", ylab = "MSE (-)",
     main = "MSE em função do número de neurônios")








