# artificial_neural_network.github.io

<code><img width="100%" src="https://github.com/lucasquemelli/artificial_neural_network.github.io/blob/main/img-three.jpg"></code>

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

Para prosseguimento da análise, foi escolhido o conjunto de 238 observações devido ao valor resultante ótimo de 3 neurônios para a camada oculta e devido ao maior número de pontos. É interessante utilizar redes com o menor número de neurônios porque uma sistema simplificado e eficiente pode gerar resultados em períodos de tempo menores.

# Treinamento da rede

Definido o número de neurônios na camada oculta para cada conjunto de dados, foi possível analisar os dois conjuntos. Foram criados dois subconjuntos de dados: treinamento (ou treino, 80 % de cada conjunto) e teste (20 % de cada conjunto). 

Com esses subconjuntos, foi possível treinar o modelo matemático, com objetivo de minimizar o somatório médio do erro quadrático e maximizar o coeficiente de determinação para a previsão da seletividade. 

# Rede definida

Pode ser visto na figura abaixo o código no R para gerar a rede neural com 1 camada oculta e 3 neurônios (238 observações) nessa camada. Para a rede com 3 neurônios na camada oculta (238 observações), foi necessário apenas mudar o número de neurônios na opção “hidden”.

![image](https://user-images.githubusercontent.com/81119854/124636503-fe51d500-de5e-11eb-90ea-409bdb3e0a09.png)

Para a rede neural da figura acima, foram utilizados os dados do subconjunto de treinamento, com 3 neurônios na camada oculta, soma do erro quadrático como fator de erro, regressão e impressão dos resultados na tela todas as vezes durante os cálculos. 

A informação “form” dentro de formula, significa qual a função objetivo, ou seja, a saída da rede – pode ser vista no primeiro parágrafo da figura. Na última linha do código, encontra-se o comando para geração do gráfico das redes neurais. 

Ambas as redes (de 5 e de 3 neurônios na camada oculta) foram construídas a partir do código acima. A rede com 3 neurônios pode ser vista abaixo.

![image](https://user-images.githubusercontent.com/81119854/124629960-52a58680-de58-11eb-98af-af375671027f.png)

Na figura acima, são vistas 28 variáveis na camada de entrada (input layer), 1 camada oculta (com 3 neurônios) e 1 variável na camada de saída (seletividade, output layer). A rede neural está completamente conectada, isto é, todos os neurônios da camada oculta estão conectados aos neurônios da camada anterior (input layer) e da camada seguinte (output layer). 

Os números identificados com a cor preta são os pesos (w), e os de cor azul são os bias (b) – estes últimos são similares a uma constante em uma equação de regressão. O peso aumenta a inclinação da função de ativação. Isso significa que o peso decide com que rapidez a função de ativação será acionada, enquanto o bias é usado para atrasar o "disparo" da função de ativação. A representação matemática para a figura acima pode ser entendida como:

![image](https://user-images.githubusercontent.com/81119854/124634275-897d9b80-de5c-11eb-85fc-97caa68461b2.png)

Para as variáveis de entrada, na primeira camada, cada bias corresponde à entrada (input) de um neurônio específico, o que significa que a equação acima varia para cada valor de bias – que liga a um neurônio diferente. 

Para o valor de saída dos neurônios da camada oculta e da função objetivo (seletividade, neste caso), é inclusa no cálculo a função de ativação. Entretanto, todos esses valores já são calculados e podem ser encontrados inserindo names(nome da rede neural) - o que neste caso é: names(n).

![image](https://user-images.githubusercontent.com/81119854/124634818-24767580-de5d-11eb-882c-2c1363957b73.png)

# Validação do modelo preditivo

Após a criação da rede neural, avalia-se estatisticamente a sua capacidade de previsão. Para a avaliação, foram utilizados gráficos de paridade, coeficiente de determinação (R²) e somatório médio do erro quadrático (MSE) para os dois conjuntos estudados.

![image](https://user-images.githubusercontent.com/81119854/124635383-bbdbc880-de5d-11eb-894d-e198b2717fe1.png)
![image](https://user-images.githubusercontent.com/81119854/124635426-cd24d500-de5d-11eb-8100-19567a7ab02e.png)

Na figura acima, estão os gráficos de paridade para o conjunto de 238 observações, com margem de erro de ± 10 %, que correlaciona as seletividades observada e calculada. Ambos os subconjuntos apresentaram ótimo ajuste, baseado no coeficiente de determinação e no somatório do erro quadrático médio. 

Como esperado, o subconjunto de treinamento (R² = 0,9988 e MSE = 0,01) apresentou melhor ajuste do que o subconjunto de teste na Figura 8 (d) (R² = 0,9938 e MSE = 0,99). Mas, ainda assim, o subconjunto de teste apresentou ótimo resultado. A diferença, possivelmente, deve-se à maior quantidade de pontos do conjunto de treinamento.

Em redes neurais artificiais, quanto mais pontos - e de melhor qualidade (sem ou com poucos erros) - melhor a previsão do modelo. Por esse motivo, redes neurais são ótimas escolhas para conjuntos 'Big Data'.

# Considerações/Observações 

As redes neurais apresentam como vantagem a resistência aos ruídos, a facilidade de utilização, a alta velocidade de processamento de dados (em alguns casos) e a alta eficiência em predição dos dados dentro do domínio utilizado. Contudo, as redes são menos interpretativas do que outros modelos e podem exigir longo período de treinamento.
