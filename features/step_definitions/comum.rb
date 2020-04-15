Dado(/^que eu esteja na home do site$/) do
    ENV['env'] == nil ? @profile_loja = 'HOM' : @profile_loja = ENV['env']
   
    puts " >> RUN PROFILE: " + @profile_loja
   
    case @profile_loja  
      when "CI"  
        visit ENVIRONMENT['HOME']['CI']['url'].gsub('{store_id}',@store_id.downcase)
      when "HOM"
        visit ENVIRONMENT['HOME']['HOM']['url'].gsub('{store_id}',@store_id.downcase)
      when "DEV"
        visit ENVIRONMENT['HOME']['DEV']['url'].gsub('{store_id}',@store_id.downcase)
      when "PRD"
        visit ENVIRONMENT['HOME']['PRD']['url'].gsub('{store_id}',@store_id.downcase)
    end
    @app.busca.button_boas_vindas.visible?.should be true
    @app.busca.button_boas_vindas.click
    #Valida se esta na página correta
    if !(@app.home.has_image_logo?) #  Validar se não tem o logotipo da loja na home page
    end
end
  
  Então(/^produto deve ser apresentado no carrinho$/) do
    ENV['env'] == nil ? @profile_loja = 'HOM' : @profile_loja = ENV['env']
  
    case @profile_loja  
      when "CI"
        visit ENVIRONMENT['CART']['CI']['url'].gsub('{store_id}',@store_id.downcase)
      when "HOM"
        visit ENVIRONMENT['CART']['HOM']['url'].gsub('{store_id}',@store_id.downcase)
      when "DEV"
        visit ENVIRONMENT['CART']['DEV']['url'].gsub('{store_id}',@store_id.downcase)
      when "PRD"
        visit ENVIRONMENT['CART']['PRD']['url'].gsub('{store_id}',@store_id.downcase)
    end
    # Valida se esta na página correta
    page.has_css?('#cart-title')
    page.has_css?('#product-name200')
    page.has_css?('div.cart-template.full-cart.span12.active > div.summary-template-holder')
  end
   
  Então("eu visualizarei a mensagem de {string} no cenário de {string}") do |mensagem, cenario|
    @app.comum.valida_mensagem(mensagem, cenario)
  end
  
  Dado('debug') do
    binding.pry
  end