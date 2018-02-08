module CoinFalcon
  class Response
    attr_reader :code, :body

    def initialize(response)
      @code = response.code.to_i
      @body = JSON.parse(response.body)
    rescue JSON::ParserError
      @body = response.body
    end
  end
end
