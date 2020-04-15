# Live_Tech_Quarentena
Repositório do projeto LiveQuarentena com Cucumber, Capybara e Ruby

## Como executar o projeto

* Importante ter o Ruby instalado

### Instalar o Bundler
`
gem install bundler
`

### Instalar as dependências do Ruby (projeto)
`
bundle install
`

### Executar localmente (minha máquina)
`
cucumber -p dailus -p hom -t @regressao
`

### Executar no servidor CI (gerando reports JSON)
`
cucumber -p dailus -p ci -t @regressao_ci
`
