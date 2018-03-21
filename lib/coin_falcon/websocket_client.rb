module CoinFalcon
  class WebsocketClient
    ENDPOINT = 'wss://ws.coinfalcon.com'.freeze
    AUTH_PATH = '/auth/feed'.freeze

    attr_accessor :channels

    def initialize(key = nil, secret = nil, endpoint = ENDPOINT)
      @endpoint = endpoint
      @channels = []
      @cipher = Cipher.new(key, secret)
    end

    def feed
      EM.run do
        @ws = Faye::WebSocket::Client.new(@endpoint, nil, { headers: headers })

        @ws.on :open do |event|
          channels.each { |channel| subscribe(channel) }
        end

        @ws.on :message do |event|
          data = JSON.parse(event.data)

          if block_given?
            yield data
          else
            p [:message, data]
          end
        end

        @ws.on :close do |event|
          p [:close, event.code, event.reason]
          @ws = nil
          EM.stop
        end
      end
    end

    def subscribe(identifier)
      request = { command: :subscribe, identifier: identifier.to_json }.to_json

      @ws.send(request)
    end

    private

    def request
      @request ||= Request.new(:get, AUTH_PATH, nil)
    end

    def headers
      @cipher.sign!(request)

      {
        'CF-API-KEY' => request['CF-API-KEY'],
        'CF-API-TIMESTAMP' => request['CF-API-TIMESTAMP'],
        'CF-API-SIGNATURE' => request['CF-API-SIGNATURE']
      }
    end
  end
end
