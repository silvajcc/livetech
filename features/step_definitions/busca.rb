Quando(/^eu buscar o produto com nome "([^"]*)"$/) do |produto|
  @produto = Produto.new(@store_id)
  @produto.nome=(MASS[@store_id]['produtos'][produto]['nome'])
  @produto.preco=(MASS[@store_id]['produtos'][produto]['preco'])
  @app.busca.realizar_busca(@produto.nome)
end

Então(/^devo estar na tela de busca valida$/) do
  @app.busca.label_resultado_busca.should have_content(@produto.nome) 
end

Então(/^devo estar na tela de busca invalida$/) do
  @app.busca.label_resultado_busca_invalida.visible?.should be true
end