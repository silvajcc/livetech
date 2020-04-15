class HomeDailus < SitePrism::Page
  @@store_id = 'DAILUS'
  
  # image
  element :image_logo, :css, 'div.header__logo.col-lg-3.col-sm-8 > div > div > a'

  def validar_logotipo
    has_image_logo? # Valida se o elemento do logotipo esta presente na página
    imagem_url = "http://www.w3.org/2000/svg"
    element_img = find('.header__logo')  # busca e atribui o elemento da imagem à variável "element_img"
    expect(element_img).to have_css(".header__logo.col-lg-3.col-sm-8 > div > div > a > svg")  # Valida se a imagem este presente dentro do elemento "element_img"
  end
end