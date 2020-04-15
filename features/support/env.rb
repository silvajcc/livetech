require "capybara"
require "capybara/cucumber"
require "capybara/dsl"
require "selenium/webdriver"
require "site_prism"
require "yaml"
require "pry"
require "open-uri"
require "capybara/rspec"
require "rspec"

include Capybara::DSL
include RSpec::Matchers

ENVIRONMENT = (YAML.load_file('./features/config/environment.yaml'))
MASS = (YAML.load_file('./features/fixtures/mass.yaml'))
CONFIG = (YAML.load_file('./features/config/config.yaml'))

Capybara.register_driver :selenium do |app| 
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :remote do |app|
    Capybara::Selenium::Driver.new(app, :browser => CONFIG['browser'], url: CONFIG['url'])
end

Capybara.register_driver :chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
      if ENV['env'] == "CI"  # cucumber -p ci - @profile_loja for igual "CI" então execute no modo texto(headless)
        # Parametros de execução no modo texto - CI/CD
        options.add_argument('--headless')
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-dev-shm-usage')
        options.add_argument('--disable-gpu')
        options.add_argument('--screenshot https://www.chromestatus.com/')
        options.add_argument('--print-to-pdf https://www.chromestatus.com/')
        options.add_argument("--disable-site-isolation-trials")
      end
        # Parametros de execução no modo normal
        options.add_argument('--ignore-certificate-errors')
        options.add_argument('--window-size=1280,720')
        options.add_argument('--disable-logging')
        options.add_argument('--disable-dev-shm-usage')
        options.add_argument('--disable-web-security')
        options.add_argument('--log-level=3')

        Capybara::Selenium::Driver.new(app, :browser => :chrome, options: options)
end

Capybara.register_driver :firefox do |app|
    Capybara::Selenium::Driver.new(app, :browser => :firefox)
  end

Capybara.configure do |config|
      driver = CONFIG['browser']
      CONFIG['remote'] = ENV['remote'] if ENV['remote']
        if CONFIG['remote']
          Capybara.server_port = CONFIG['server_port']
          Capybara.server_host = CONFIG['server_host']
          Capybara.app_host = "#{Capybara.server_host}:#{Capybara.server_port}"
          driver = :remote
        end
        
        Capybara.default_driver = driver
        Capybara.javascript_driver = driver
        Capybara.default_max_wait_time = CONFIG['default_max_wait_time']
end