require 'coin_falcon'

# client = CoinFalcon::Client.new(ENV['CF_KEY'], ENV['CF_SECRET'])
#
# p client.my_trades(market: 'ETH-BTC')

websocket_client = CoinFalcon::WebsocketClient.new(ENV['CF_KEY'], ENV['CF_SECRET'])

websocket_client.feed
