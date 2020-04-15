require 'capybara/dsl'
require 'yaml'

AfterConfiguration do |config|
    Dir.mkdir('reports') unless Dir.exist?('reports')
  end

Before do |scenario|
  if !$dunit
    ENV['env'] == nil ? $env = 'HOM' : $env = ENV['env']
    $store_id = ENV['store_id']
    $dunit = true
    $first = true
    $feature = scenario.feature.name
    $app = App.new($store_id)
  end
    @mass_bkp = (YAML.load_file('./features/fixtures/mass.yaml'))
    @store_id = $store_id
    @app = $app
    @env = $env
    $step_index = 0
    $scenario = scenario
    $scenario_path = "#{$scenario.feature.name}/#{$scenario.name}".gsub(' - ','').gsub(' ','-').gsub('(#','').gsub(')','')  # Gera url para o screenshot
    $scenario_path += '-' + Time.now.strftime('%d%m%Y%H%M%S').to_s
end

Before('@carrinho') do |scenario|
  @carrinho_model = CarrinhoModel.new($store_id, ENV['cart_prefix'])
  @produto = Produto.new(@store_id)
end

Before('@appVersion') do |scenario|
  if ($feature != scenario.feature.name || $first) && CONFIG['verify_version']
    $first = false if $first == true
    $feature = scenario.feature.name
    puts $store_id + " | CatalogFront versão atual build: " + $appVersion.build_number[:catalogFront]
    puts $store_id + " | Checkout versão atual build: " + $appVersion.build_number[:checkout]
    puts $store_id + " | SServ versão atual build: " + $appVersion.build_number[:sserv]
    if $appVersion.build_number[:catalogFront] != $appVersion.get_catalog_front_version
      warn('Versão do catalogo mudou')
      puts "CatalogFront versão atual build: " + $appVersion.build_number[:catalogFront]
    end
    if $appVersion.build_number[:checkout] != $appVersion.get_checkout_version
      warn('Versão do checkout mudou')
      puts "Checkout versão atual build: " + $appVersion.build_number[:checkout]
    end
    if $appVersion.build_number[:sserv] != $appVersion.get_sserv_version
      warn('Versão do checkout mudou')
      puts "SServ versão atual build: " + $appVersion.build_number[:sserv]
    end
  end
end

AfterStep  do |step|
    contador = if $step_index == 2; 2; else; ($step_index / 2) + 1; end
    if $step_index < $scenario.test_steps.count
      step_name = "step-#{contador}-#{$scenario.test_steps[$step_index].text}"
      step_name = step_name.gsub(' - ','').gsub(' ','-').gsub('"',"")
      step_name = step_name.gsub('#$%$@#','Senha')
    end
    step_name = "step-#{contador}" if step_name.size > 85 
    $step_index += 2
    path_name = "reports/#{$store_id}/#{$scenario_path}/#{step_name}.png"
    page.save_screenshot(path_name)
    embed(path_name, 'image/png', 'SCREENSHOT')
end

After do |scenario|
    if scenario.failed?
      path_name = "/reports/image.png"
      page.save_screenshot(path_name)
      embed(path_name, 'image/png', 'Screenshot')
    end
    MASS[@store_id] = @mass_bkp[@store_id]
    url_atual = (URI.parse(current_url)).to_s
    case @profile_loja
      when "CI"
        url_base = ENVIRONMENT['HOME']['CI']['url'].gsub('{store_id}',@store_id.downcase)
      when "HOM"
        url_base = ENVIRONMENT['HOME']['HOM']['url'].gsub('{store_id}',@store_id.downcase)
      when "DEV"
        url_base = ENVIRONMENT['HOME']['DEV']['url'].gsub('{store_id}',@store_id.downcase)
      when "PRD"
        url_base = ENVIRONMENT['HOME']['PRD']['url'].gsub('{store_id}',@store_id.downcase)
    end
    unless url_atual.include?("data")
      # Fazer logout
      page.reset_session!  # faz logout - Limpa a sessão do usuário
       #visit url_base
       #@app.home.logout
    end
  
      if page.driver.browser.window_handles.count > 1
        puts page.driver.browser.window_handles.count
        page.driver.browser.close
        last_handle = page.driver.browser.window_handles.last
        page.driver.browser.switch_to.window(last_handle)
      end
end