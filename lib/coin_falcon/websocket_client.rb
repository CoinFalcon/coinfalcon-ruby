require 'pry-byebug'
module CoinFalcon
  class WebsocketClient
    # ENDPOINT = 'ws://localhost:3000/cable'
    # ENDPOINT = 'wss://ws.coinfalcon.com'
    # ENDPOINT = 'wss://staging.coinfalcon.com/cable'
    ENDPOINT = 'wss://ws-staging.coinfalcon.com'

    def initialize(key = nil, secret = nil)
      @key = key
      @secret = secret
      @cipher = Cipher.new(@key, @secret)
    end

    def feed
      EM.run do
        @ws = Faye::WebSocket::Client.new(ENDPOINT, nil, { headers: headers })

        @ws.on :open do |event|
          p [:open]

          identifier = { channel: 'UserTradesChannel', market: 'ETH-BTC' }.to_json
          request = { command: :subscribe, identifier: identifier }.to_json
          puts request

          @ws.send(request)
        end

        @ws.on :message do |event|
          p [:message, JSON.parse(event.data)]
        end

        @ws.on :close do |event|
          p [:close, event.code, event.reason]
          @ws = nil
          EM.stop
        end
      end
    end

    private

    def headers
      request = Request.new(:get, '/auth/feed', nil)
      @cipher.sign!(request)

      {
        'CF-API-KEY' => request['CF-API-KEY'],
        'CF-API-TIMESTAMP' => request['CF-API-TIMESTAMP'],
        'CF-API-SIGNATURE' => request['CF-API-SIGNATURE']
      }
    end
  end
end
