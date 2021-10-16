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

x
summary(x)

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
#View(dadosN)
dadosN <- dadosN[-c(226),]
#View(dadosN)
dados <- dados[-c(226),]
#View(dados)



#Partição aleatória dos Dados
set.seed(222)
ind <- sample(2,nrow(dadosN),replace=TRUE,prob=c(0.8,0.2))
training <- dadosN[ind==1,]
testing <- dadosN[ind==2,]

View(training)

plot(rownames(training),training$y,
     xlab = "n° de observações (-)",
     ylab="Seletividade 'y' (-)")
lines(rownames(testing),testing$y,type="p",col=2)
legend("topleft",legend=c("training","testing"),col=c(1,2),pch=1)

plot(training$PI0102,training$PI0215,
     xlab="PI0102",ylab="PI0215")
lines(testing$PI0102,testing$PI0215,type="p",col=2)
legend("bottomright",legend=c("training","testing"),col=c(1,2),pch=1)


# Seletividade = FC0619/FI0219
#y <- dadosN$FC0619/dadosN$FI0219
#dadosN <- cbind(dadosN,y)

#dadosN <- dadosN[,c(6,18,5,28,17)]
#dadosN <- dadosN[,c(6,18,5,28,17,29)]

View(dadosN)
#dadosN <- dadosN[-c(226),]
#View(dadosN)
#install.packages("ellipsis")

# Retirar as variáveis que formam a seletividade do conjunto training
#training$FC0619 <- NULL
#training$FI0219 <- NULL


allVars <- colnames(dadosN)
predictorVars <- allVars[!allVars%in%"y"]
predictorVars <- paste(predictorVars,collapse="+")
form <- as.formula(paste("y~",predictorVars,collapse="+"))


#install.packages("neuralnet")



library(neuralnet)

set.seed(333)
n <- neuralnet(formula = form, data = training, hidden = c(3),
             err.fct="sse",linear.output=TRUE,lifesign="full")

?neuralnet

names(n)
n$net.result
n$result.matrix
plot(n,radius=0.1,information=T)

#Usando o conjunto de treinamento:
  predictions.train <- compute(n,training[,-ncol(training)])

#Usando o conjunto de teste:
  predictions.test <- compute(n,testing[,-ncol(testing)])
  
#Usando todo o conjunto de dados:
  predictions.all <- compute(n,dadosN[,-ncol(dadosN)])
  
#Coeficiente de Determinação Primeira Saída 
SQtot.train <- sum((training$y-mean(training$y))^2)
SQres.train <- sum((training$y-predictions.train$net.result)^2)
R2.train <- 1-SQres.train/SQtot.train
R2.train

#Coeficiente de Determinação do teste 
SQtot.test <- sum((testing$y-mean(testing$y))^2)
SQres.test <- sum((testing$y-predictions.test$net.result)^2)
R2.test <- 1-SQres.test/SQtot.test
R2.test



#Unscaled results for the prediction (training)
predictions.train.unscaled <- predictions.train$net.result*(max(dados$y)-
                                                            min(dados$y))+min(dados$y)  
predictions.train

#Unscaled results for the training set
training.unscaled <- training$y*(max(dados$y)-min(dados$y))+min(dados$y)
training.unscaled

MSE.train <- sum((training.unscaled-predictions.train.unscaled)^2)/
  nrow(training)
MSE.train



#Unscaled results for the prediction (testing)
predictions.test.unscaled <- predictions.test$net.result*(max(dados$y)-
                                                            min(dados$y))+min(dados$y)  
#predictions.train.unscaled
#predictions.train$net.result
#max(dados$y)
#min(dados$y)
#View(dados)

#Unscaled results for the testing set
testing.unscaled <- testing$y*(max(dados$y)-min(dados$y))+min(dados$y)
#training.unscaled

MSE.test <- sum((testing.unscaled-predictions.test.unscaled)^2)/
  nrow(testing)
MSE.test




plot(training.unscaled,predictions.train.unscaled,
     xlim = c(0,15), ylim = c(0,15),xlab=
       "Observed Conversion",ylab="Predicted Conversion")
abline(0,1,lty=2) #linha de 45 graus
R2.train.plot <- round(R2.train,digits=4)
text(x=1.8,y=14,label=bquote("R²" ==.(R2.train.plot)))




# gráfico de paridade do treinamento
plot(training.unscaled,predictions.train.unscaled,
          xlim = c(0,15), ylim = c(0,15),
     xlab="Seletividade observada",ylab="Seletividade calculada",
     main = "Paridade do conjunto treinamento")
abline(0,1,lty=2) #linha de 45 graus
abline(1.5,1,lty=2,col=2) #linha de 45 graus
abline(-1.5,1,lty=2,col=2) #linha de 45 graus
R2.train.plot <- round(R2.train,digits=4)
MSE.train.plot <- round(MSE.train,digits = 2)
text(x=2.0,y=14,label=bquote("R²" ==.(R2.train.plot)))
text(x=2.0,y=13,label=bquote("MSE" ==.(MSE.train.plot)))

# gráfico de paridade do teste
plot(testing.unscaled,predictions.test.unscaled,
     xlim = c(0,15), ylim = c(0,15),xlab=
       "Seletividade observada",ylab="Seletividade calculada",
     main = "Paridade do conjunto teste")
abline(0,1,lty=2) #linha de 45 graus
abline(1.5,1,lty=2,col=2) #linha de 45 graus
abline(-1.5,1,lty=2,col=2) #linha de 45 graus
R2.test.plot <- round(R2.test,digits=4)
MSE.test.plot <- round(R2.test,digits = 2)
text(x=2.0,y=14,label=bquote("R²" ==.(R2.test.plot)))
text(x=2.0,y=13,label=bquote("MSE" ==.(MSE.test.plot)))

?neuralnet
