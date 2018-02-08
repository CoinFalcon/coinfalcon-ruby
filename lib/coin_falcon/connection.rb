module CoinFalcon
  class Connection
    def initialize(key, secret, endpoint, version)
      @cipher = Cipher.new(key, secret)
      @http = initialize_http(endpoint)
      @version = version
    end

    def get(path, params = nil)
      request :get, path, params
    end

    def post(path, params)
      request :post, path, params
    end

    def delete(path, params = {})
      request :delete, path, params
    end

    private

    attr_reader :cipher, :http, :version

    def initialize_http(endpoint)
      uri = URI.parse(endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      http
    end

    def request(method, path, params)
      request = Request.new(method, api(path), params)
      cipher.sign!(request)

      Response.new(http.request(request))
    end

    def api(path)
      "/api/v#{version}/#{path}"
    end
  end
end
