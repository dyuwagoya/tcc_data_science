### Trabalho de Conclusão apresentado para obtenção do título de especialista em Data Science e Analytics USP/Esalq

# Estimação de Modelos Supervisionados de Machine Learning para Seleção de Variáveis Explicativas e Análise da Probabilidade do Fluxo de Caixa Livre Positivo

## Introdução

O Fluxo de Caixa Livre representa a quantidade de dinheiro disponível após a empresa ter atendido a todos os seus gastos operacionais, investimentos em ativos fixo e pagamento de dividendo, um número positivo indica que a empresa gerou caixa suficiente a partir de suas atividades operacionais para financiar seus investimentos em ativo fixo e pagar os dividendos. Um número negativo sugere que a empresa precisou obter dinheiro de outras fontes, como empréstimos ou emissão de ações ordinárias, para financiar seus investimentos em ativo fixo ou sua operação. O objetivo deste trabalho foi de realizar uma seleção de variáveis explicativas e utilizar as variáveis selecionadas para analisar a probabilidade do fluxo de caixa livre ser positivo, e avaliar a performance desta análise com o numero de variáveis reduzidas. Para a redução de variáveis explicativas foi estimado um modelo análise de regressão logística com procedimento “stepwise” que retornou apenas duas variáveis estatisticamente significantes das 6 variáveis explicativas iniciais. Para a análise da probabilidade do evento fluxo de caixa positivo foram estimados os modelos de análise de regressão logística binária e redes neurais feedforward.  Comparativamente, a rede neural feedforward superou o modelo de regressão logística em termos de sensibilidade, acurácia e auc-ROC

## Algoritimos

* Regressão Logística
* Procedimento Stepwise
* Rede Neural

## License

[License]

[LICENSE]: https://github.com/dyuwagoya/tcc_data_science/blob/main/LICENSE
