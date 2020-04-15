# Classe Produto que deve conter toda a informação do produto que será utilizado no teste
class Produto

  # Nome do produto
  attr_accessor :nome
  # Descrição do produto
  attr_accessor :descricao
  # Tamanho do produto
  attr_accessor :tamanho
  # Marca do Produto
  attr_accessor :marca

  # Construtor padrão
  def initialize(store_id)
    @nome = "Corretivo Soft New"
    @preco = "21,12"
    @produzido = true
    @unidade_quantidade = 1
    @marca = "Soft"
    @store_id = store_id
  end
  
  # Construtor com nome, preco e quantidade 
  def self.new_produto(store_id, nome, preco)
    @store_id = store_id
    @nome = nome
    @preco = preco
    @marca = ""
  end
  
  # Retorna o preço do produto (já arredondado) (valor unitario)
  # ====== @return
  #  preco (float)
  def preco
    return @preco.ceil(2)
  end
  
  # Seta o preço do produto
  # ====== @params
  # * +preco+ - Type: String - pode estar fora do formato (conter "R$"" ou ",").
  def preco=(preco)
    @preco = preco.to_s.delete("R$").delete(" ").gsub(",", ".").to_f
  end

end