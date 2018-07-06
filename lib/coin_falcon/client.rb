module CoinFalcon
  # Client executes requests against the CoinFalcon API.
  #
  class Client
    ENDPOINT = 'https://coinfalcon.com'.freeze
    VERSION = 1

    def initialize(key, secret, endpoint = ENDPOINT, version = VERSION)
      @conn = Connection.new(key, secret, endpoint, version)
    end

    def accounts
      path = 'user/accounts'

      conn.get(path)
    end

    def create_order(order)
      path = 'user/orders'

      conn.post(path, order)
    end

    def cancel_order(id)
      path = "user/orders/#{id}"

      conn.delete(path)
    end

    def my_orders(params = nil)
      path = 'user/orders'

      conn.get(path, params)
    end

    def my_trades(params = nil)
      path = 'user/trades'

      conn.get(path, params)
    end

    def deposit_address(currency)
      path = 'account/deposit_address'

      conn.get(path, { currency: currency })
    end

    def deposit_history(params = nil)
      path = 'account/deposits'

      conn.get(path, params)
    end

    def deposit_details(id)
      path = 'account/deposit'

      conn.get(path, { id: id })
    end

    def create_withdrawal(params)
      path = 'account/withdraw'

      conn.post(path, params)
    end

    def withdrawal_details(id)
      path = 'account/withdrawal'

      conn.get(path, { id: id })
    end

    def withdrawal_history(params = nil)
      path = 'account/withdrawals'

      conn.get(path, params)
    end

    def cancel_withdrawal(id)
      path = "account/withdrawals/#{id}"

      conn.delete(path)
    end

    def trades(market, params = nil)
      path = "markets/#{market}/trades"

      conn.get(path, params)
    end

    def orderbook(market, params = nil)
      path = "markets/#{market}/orders"

      conn.get(path, params)
    end

    def fees
      path = 'user/fees'

      conn.get(path)
    end

    def markets
      path = 'markets'

      conn.get(path)
    end

    private

    attr_reader :conn
  end
end
