# CoinFalcon Ruby Library

The CoinFalcon Ruby Library provides convenient access to the CoinFalcon API from applications written in the Ruby language.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coin_falcon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coin_falcon

## Usage

The library needs to be configured with your account's `key` and `secret` which is available in your CoinFalcon Dashboard:

```ruby
require 'coin_falcon'

client = CoinFalcon::Client.new(key, secret)
```

It is also possible to set up an API `endpoint` and `version`:

```ruby
require 'coin_falcon'

client = CoinFalcon::Client.new(key, secret, endpoint, version)
```

Defaults:

```ruby
ENDPOINT = 'https://staging.coinfalcon.com'
VERSION = 1
```

### Accounts

Get a list of your trading accounts.

```ruby
client.accounts
```

### Create order

```ruby
client.create_order(market: 'ETH-BTC', operation_type: :limit_order, order_type: :buy, size: 1, price: 0.01)
```

### Cancel order

```ruby
client.cancel_order(order_id)
```

### List orders

```ruby
client.my_orders
```

### List trades

```ruby
client.my_trades
```

### Deposit address

```ruby
client.deposit_address('btc')
```

### Deposit history

```ruby
client.deposit_history
```

### Deposit details

```ruby
client.deposit_details(deposit_id)
```

### Create withdrawal

```ruby
client.create_withdrawal(currency: :btc, address: 'your_address_here', amount: 0.1)
```

### Withdrawal details

```ruby
client.withdrawal_details(withdrawal_id)
```

### Withdrawal history

```ruby
client.withdrawal_history(params)
```

### Cancel withdrawal

```ruby
client.cancel_withdrawal(withdrawal_id)
```

### List market's trades

```ruby
client.trades('ETH-BTC')
```

### List orderbook

```ruby
client.orderbook('ETH-BTC')
client.orderbook('ETH-BTC', level: 3)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thetonyrom/coin_falcon

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
