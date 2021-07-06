# artificial_neural_network.github.io
Este é um projeto que utiliza redes neurais artificiais para a previsão da seletividade de um produto final de uma planta química industrial.

Inicialmente, foi escolhida 1 camada oculta para fazer uma rede de 3 camadas totais (camada de entrada, camada oculta e camada de saída). Com essa configuração, foi realizado um teste para determinar o número de neurônios que promove o melhor desempenho na rede, tendo como objetivo a maximização do coeficiente de determinação (R²) e a minimização do somatório médio do erro quadrático (MSE).

A seguir, o código no RStudio para a inserção dos dados, para a limpeza de outliers Mahalanobis, para a partição dos dados em conjunto treinamento e em conjunto teste e para a definição da coluna de seletividade pelo aumento do produto (FC0619) e minimização do resíduo de vapor (FI0219).

Foram utilizados dois conjuntos. Um conjunto com uma limpeza mais rígida de dados, resultando em 41 observações. Outro conjunto com uma limpeza de dados menos rígida, resultando em 238 observações. 

# Teste com o conjunto de 41 observações

![image](https://user-images.githubusercontent.com/81119854/124601585-63e19980-de3e-11eb-92a8-e6793897e6b2.png)
![image](https://user-images.githubusercontent.com/81119854/124601748-94293800-de3e-11eb-8941-7af55db31a3a.png)
![image](https://user-images.githubusercontent.com/81119854/124602025-d488b600-de3e-11eb-9528-4964c3ff34b2.png)
![image](https://user-images.githubusercontent.com/81119854/124602111-e79b8600-de3e-11eb-952a-e3a027dd1496.png)

A seletividade foi definida pela divisão da variável de produto de anidrido pela variável de vazão de vapor residual. O código acima é similar para o conjunto de 238 observações.

Com os dados do algoritmo acima, foi possível construir as figuras abaixo:

![image](https://user-images.githubusercontent.com/81119854/124603541-6644f300-de40-11eb-8473-3262206fb7db.png)
![image](https://user-images.githubusercontent.com/81119854/124603615-7eb50d80-de40-11eb-858a-3c2fb3101e7e.png)

# Teste com o conjunto de 238 observações

O procedimento para análise do conjunto de 238 observações foi similar ao procedimento de análise para o conjunto de 42 observações. Com os códigos no RStudio, foi possível construir as figuras abaixo:

![image](https://user-images.githubusercontent.com/81119854/124605192-0a7b6980-de42-11eb-9471-3257d610705a.png)
![image](https://user-images.githubusercontent.com/81119854/124605252-18c98580-de42-11eb-8ef5-99c39ff4be71.png)

# Análise dos testes com os dois conjuntos

Foram testadas redes com até 25 neurônios na camada oculta. Contudo, foi possível observar que um número de neurônios pequeno foi suficiente para atingir um alto valor de R² e baixo valor do MSE. 

Observa-se nas figuras do conjunto de 41 observações que o número de 5 neurônios realizou uma boa otimização. Além desse número de neurônios, os valores de R² e MSE se mantiveram razoavelmente constantes (com pouca oscilação). Para o conjunto de 238 observações, esse número foi o de 3 neurônios.

É interessante utilizar redes com o menor número de neurônios porque uma sistema simplificado e eficiente pode gerar resultados em períodos de tempo menores.

# Treinamento da rede

Definido o número de neurônios na camada oculta para cada conjunto de dados, foi possível analisar os dois conjuntos. Foram criados dois subconjuntos de dados: treinamento (ou treino, 80 % de cada conjunto) e teste (20 % de cada conjunto). 

Com esses subconjuntos, foi possível treinar o modelo matemático, com objetivo de minimizar o somatório médio do erro quadrático e maximizar o coeficiente de determinação para a previsão da seletividade. 

# Rede definida

Pode ser visto na figura abaixo o código no R para gerar a rede neural com 1 camada oculta e 5 neurônios (41 observações) nessa camada. Para a rede com 3 neurônios na camada oculta (238 observações), foi necessário apenas mudar o número de neurônios na opção “hidden”.

![image](https://user-images.githubusercontent.com/81119854/124628770-2e957580-de57-11eb-9b28-628b5199bce2.png)

Para a rede neural da figura acima, foram utilizados os dados do subconjunto de treinamento, com 5 neurônios na camada oculta, soma do erro quadrático como fator de erro, regressão e impressão dos resultados na tela todas as vezes durante os cálculos. 

A informação “form” dentro de formula, significa qual a função objetivo, ou seja, a saída da rede – pode ser vista no primeiro parágrafo da figura. Na última linha do código, encontra-se o comando para geração do gráfico das redes neurais. 

Ambas as redes (de 5 e de 3 neurônios na camada oculta) foram construídas a partir do código acima. As redes neurais podem ser vistas abaixo.

![image](https://user-images.githubusercontent.com/81119854/124629960-52a58680-de58-11eb-98af-af375671027f.png)


