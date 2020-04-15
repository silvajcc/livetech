# Modelo de carrinho que deve conter todas as alterações no carrinho durante testes de Ckout
class CarrinhoModel 

  # Lista de produtos do carrinho - Array[ Produto ]
  attr_accessor :produtos
  # Url usada para navegar no carrinho adicionando produtos
  attr_accessor :url
  
  # Contrutor padrão
  def initialize(store_id, cart_prefix)
    @produtos = Array.new
    @store_id = store_id
  end

  def add_produto_por_massa(produto, quantidade)
    p = Produto.new(@store_id)
    p.nome=(MASS[@store_id]['produtos'][produto]['nome'])
    p.preco=(MASS[@store_id]['produtos'][produto]['preco'])
    p.quantidade=(quantidade-1)
    add_produto(p, p.sku, quantidade)
  end

end