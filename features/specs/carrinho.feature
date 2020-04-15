#language: pt
#utf-8

@checkout @carrinho @appVersion 
Funcionalidade: Carrinho
  Eu como cliente da dailus
  desejo utilizar a funcionalidade de compra
  para isso é necessário que todas as funcionalidades
  de checkout estejam funcionando

Contexto: Adicionar produtos no carrinho
  Dado que eu esteja na home do site

@positivo @dailus @regressao
Cenário: Validar que o produto foi adicionado corretamente ao carrinho
  Quando adicionar um produto no carrinho
  Então produto deve ser apresentado no carrinho

@positivo @dailus @regressao
Cenário: Limpar minha sacola
  Quando adicionar um produto no carrinho
  E clicar para limpar minha sacola
  Então exibirá mensagem que minha sacola esta vazia