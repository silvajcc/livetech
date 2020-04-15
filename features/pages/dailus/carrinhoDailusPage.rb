class CarrinhoDailus < SitePrism::Page
  @@store_id = 'DAILUS'

 # label
  element :label_produto_header, :css, 'li:nth-child(1) > div > div.product__header > div.product__media > a'
  element :label_sacola_vazia, :css, '#cartLoadedDiv > div.empty-cart-content > h2'

 # button
  element :button_comprar, :css, '.product__buy > a'
  element :button_remove_primeiro_item, :css, '#item-remove-218'

  # link
  element :link_header_pinceis, :css, 'ul.menu.menu--main > li:nth-child(6) > a'

  def compra_primeiro_produto_disponível
    link_header_pinceis.click
    label_produto_header.click
    if page.has_css?('.product__buy > a')
      button_comprar.click
    end
  end

end