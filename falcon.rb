require 'coin_falcon'

# client = CoinFalcon::Client.new(ENV['CF_KEY'], ENV['CF_SECRET'])
#
# p client.my_trades(market: 'ETH-BTC')

# websocket_client = CoinFalcon::WebsocketClient.new(ENV['CF_KEY'], ENV['CF_SECRET'], 'wss://ws-staging.coinfalcon.com')
websocket_client = CoinFalcon::WebsocketClient.new(ENV['CF_KEY'], ENV['CF_SECRET'], 'ws://localhost:3000/cable')

websocket_client.channels << { channel: 'TickerChannel' } << { channel: 'OrderbookChannel', market: 'ETH-BTC' }
websocket_client.feed { |msg| puts ">>>#{msg}" }
