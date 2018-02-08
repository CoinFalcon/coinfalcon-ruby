require 'net/http'
require 'json'
require 'openssl'

require 'coin_falcon/client'

require 'coin_falcon/version'

module CoinFalcon
  @api_base = 'https://staging.coinfalcon.com/api/v1/'

  class << self
    attr_accessor :api_base
  end
end
