Quando("adicionar um produto no carrinho") do
  @app.home.image_logo.click
  @app.carrinho.compra_primeiro_produto_disponível
end

Quando("clicar para limpar minha sacola") do
  @app.carrinho.button_remove_primeiro_item.click
end

Então("exibirá mensagem que minha sacola esta vazia") do
  @app.carrinho.label_sacola_vazia
end