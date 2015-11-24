# load rb files from app/middlewares directory
# these are our custom middlewares
Dir[Rails.root.join('app/middlewares/*.rb')].each{|f| require f}

Rails.application.config.tap do |config|
  # disable unnecessary default middlewares

  config.middleware.delete ::Rack::Sendfile
  # Convenient POST method
  config.middleware.delete ::Rack::MethodOverride

  config.middleware.delete ::Rack::ETag

  # Unique request id
  # config.middleware.delete ::ActionDispatch::RequestId

  # Session
  # config.middleware.delete ::ActionDispatch::Cookies
  # config.middleware.delete ::ActionDispatch::Session::CookieStore
  # config.middleware.delete ::ActionDispatch::Flash

  # Http headers convenient accessors
  # config.middleware.delete ::ActionDispatch::Http::Headers

  # remove headers: X-Frame-Options, X-XSS-Protection, X-Content-Type-Options
  # config.action_dispatch.default_headers = {}

  # configure Rack::Cors
  config.middleware.insert_before 0, "Rack::Cors" do
    allow do
      origins ENV['CONFIG_ACTION_DISPATCH_DEFAULT_HEADERS_CONTROL_ALLOW_ORIGIN'] || '*'
      resource '*', headers: :any, 
      methods: [:get, :post, :options, :put, :patch, :delete],
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client']
    end
  end
end