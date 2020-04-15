#language: pt
#utf-8

@busca @appVersion @catalogo
Funcionalidade: Busca
  Eu como cliente 
  Quero buscar produtos
  Para visualizar mais informações sobre eles

Contexto: Acessar a loja
   Dado que eu esteja na home do site

@positivo @dailus @regressao
Cenário: Realizar Busca Por Um Produto Valido
  Quando eu buscar o produto com nome "produto_valido_1"
  Então devo estar na tela de busca valida

@negativo @negativo @dailus @regressao
Cenário: Realizar Busca Por Um Produto Invalido
  Quando eu buscar o produto com nome "produto_invalido_1"
  Então devo estar na tela de busca invalida