class App

  attr_accessor :store_id

  def initialize(store_id)
    @store_id = set_store_id(store_id)
  end
  
  def set_store_id(store_id)
    aux = store_id[0]
    r = store_id.downcase
    r[0] = aux
    return r
  end

  def comum
    Comum.new
  end

  def home
    Kernel.const_get('Home' + @store_id).new
  end

  def busca
    Kernel.const_get('Busca' + @store_id).new
  end

  def carrinho
    Kernel.const_get('Carrinho' + @store_id).new
  end
end