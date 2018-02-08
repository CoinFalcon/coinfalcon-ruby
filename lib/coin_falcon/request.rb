module CoinFalcon
  class Request
    VERBS = {
      :get => Net::HTTP::Get,
      :post => Net::HTTP::Post,
      :delete => Net::HTTP::Delete
    }

    def initialize(method, path, params)
      case method
      when :get
        full_path = encode_path_params(path, params)
        @request = VERBS[method].new(full_path)
      else
        @request = VERBS[method].new(path)
        @request.body = params.to_json
      end
    end

    def to_a
      [verb, path, body]
    end

    def method_missing(method, *args)
      if request.respond_to?(method)
        request.send(method, *args)
      else
        super
      end
    end

    private

    attr_reader :request

    def verb
      request.method
    end

    def encode_path_params(path, params)
      return path unless params

      encoded = URI.encode_www_form(params)
      [path, encoded].join('?')
    end
  end
end
