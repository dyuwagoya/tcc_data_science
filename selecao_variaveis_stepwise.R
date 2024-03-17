# Instalação e Carregamento de Todos os Pacotes

pacotes <- c("tidyverse", "correlation", "jtools", "Hmisc")

options(rgl.debug = TRUE)

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T)
} else {
  sapply(pacotes, require, character = T)
}

#-------------------------------------------------------------------------

# Importação do dataset
df <- read_csv("./data/dataset_2001_a_2023.csv") 

# Estatísticas descritivas univariadas da base de dados
summary(df)

# grafico correlacao entre as variaveis
df %>%
  correlation(method = "pearson") %>%
  plot()

# Coeficientes de correlação de Pearson para cada par de variáveis
rho <- rcorr(as.matrix(df[,2:8]), type="pearson")

corr_coef <- rho$r # Matriz de correlações
corr_sig <- round(rho$P, 5) # Matriz com p-valor dos coeficientes

# Criação de uma variável binária para servir como uma variável dependente. 
# 1: para fluxo de caixa livre positivo
# 0: para fluxo de caixa livre negativo
df %>%
  mutate(fcl_binario = ifelse(fcl >= 0,
                        yes = "1",
                        no = "0"),
         fcl_binario = factor(fcl_binario)) -> df

# Estimando o modelo logístico binário sem a variavel data e fcl
modelo <- glm(formula = fcl_binario ~ . -data -fcl,
                         data = df,
                         family = "binomial")

#Parâmetros do modelo
summary(modelo)

# Extração dos outputs do modelo utilizando a função 'summ' do pacote 'jtools'
summ(modelo, confint = T, digits = 5, ci.width = .95)

# Procedimento Stepwise para seleção das variaveis estatisticamente significantes
step_modelo <- step(object = modelo,
                        k = qchisq(p = 0.05, df = 1, lower.tail = FALSE))
summary(step_modelo)

# Extração do valor de Log-Likelihood (LL)
logLik(step_modelo)

# Extração dos outputs do modelo utilizando a função 'summ' do pacote 'jtools'
summ(step_modelo, confint = T, digits = 5, ci.width = .95)

# Calculo manual do Chi2
# chi2 = -2*(LLmodelo_nulo - LL modelo)
modelo_nulo <- modelo <- glm(formula = fcl_binario ~ 1,
                             data = df,
                             family = "binomial")
logLik(modelo_nulo)

chi2 <- -2*(logLik(modelo_nulo) - logLik(step_modelo))
chi2

pchisq(chi2, df=2, lower.tail=F)
# pvalue = 1.729451e-09 pelo menos um beta estatisticamente sifnificante

# AIC (Akaiki Info Criterion): -2*LLmodelo + 2(K+1), onde K é a quantidade de betas do modelo
AIC <- -2*logLik(step_modelo) + 2*(2+1)
AIC #AIC = 84.98291

# BIC(Bayesian Info Criterion): -2*LLmodelo +(K+1) * ln(n), onde n é o tamanho da amostra
BIC <- -2*logLik(step_modelo) + (2+1)*log(100)
BIC # BIC = 92.79842

df_exportar <- select(df, -tech, -adm, -juros, -ativo, -fcl)
write.csv(df_exportar,"./data/modelo_step.csv", row.names = FALSE)
