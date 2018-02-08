module CoinFalcon
  # Client executes requests against the CoinFalcon API.
  #
  class Client
    KEY_HEADER  = 'CF-API-KEY'.freeze
    TIME_HEADER = 'CF-API-TIMESTAMP'.freeze
    SIGN_HEADER = 'CF-API-SIGNATURE'.freeze

    attr_reader :api_key, :api_secret

    def initialize(api_key, api_secret)
      @api_key = api_key
      @api_secret = api_secret
    end

    def orderbook(market)
      url = build_url("markets/#{market}/orders")

      response = get(url)

      JSON.parse(response.body)
    end

    def accounts
      url = build_url('user/accounts')

      response = get(url)

      JSON.parse(response.body)
    end

    private

    def build_url(path)
      URI(CoinFalcon.api_base + path)
    end

    def headers(method, path, body = nil)
      timestamp = Time.now.to_i

      {
        KEY_HEADER => api_key,
        TIME_HEADER => timestamp,
        SIGN_HEADER => sign(timestamp, method, path, body),
        'Content-Type' => 'application/json'
      }
    end

    def sign(timestamp, method, path, body)
      payload = build_payload(timestamp, method, path, body)

      OpenSSL::HMAC.hexdigest('sha256', api_secret, payload)
    end

    def build_payload(timestamp, method, path, body)
      [timestamp, method, path, body].compact.join('|')
    end

    def get(url)
      request = Net::HTTP::Get.new(url)

      headers('GET', url.path).each do |header, value|
        request[header] = value
      end

      http = Net::HTTP.new(url.hostname, url.port)
      http.use_ssl = true

      http.request(request)
    end
  end
end
