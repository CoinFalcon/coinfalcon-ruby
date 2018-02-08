module CoinFalcon
  class Cipher
    ALGORITHM = 'SHA256'.freeze

    KEY_HEADER  = 'CF-API-KEY'.freeze
    TIME_HEADER = 'CF-API-TIMESTAMP'.freeze
    SIGN_HEADER = 'CF-API-SIGNATURE'.freeze

    def initialize(key, secret)
      @key = key
      @secret = secret
    end

    def sign!(request)
      headers(request.to_a).each do |header, value|
        request[header] = value
      end
    end

    private

    attr_reader :key, :secret

    def headers(attrs)
      timestamp = Time.now.to_i

      {
        KEY_HEADER => key,
        TIME_HEADER => timestamp,
        SIGN_HEADER => encode(timestamp, attrs),
        'Content-Type' => 'application/json'
      }
    end

    def encode(timestamp, attrs)
      payload = build_payload(timestamp, attrs)

      OpenSSL::HMAC.hexdigest(ALGORITHM, secret, payload)
    end

    def build_payload(timestamp, attrs)
      [timestamp, *attrs].compact.join('|')
    end
  end
end
