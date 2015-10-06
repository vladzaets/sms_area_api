module SmsAreaApi
  class Client
    attr_accessor :api_key

    def initialize(api_key)
      self.api_key = api_key
    end

    def request(params)
      params[:api_key] = api_key
      response = RestClient.post 'http://sms-area.org/stubs/handler_api.php', params
      data = response.split(':')
      state = data.first

      case state
      when 'ACCESS_NUMBER'
        return {
          state: state,
          id: data[1],
          access_number: data[2]
        }
      when 'STATUS_OK', 'STATUS_ACCESS', 'STATUS_ACCESS_SCREEN'
        return {
          state: state,
          code: data[1]
        }
      when 'ACCESS_BALANCE'
        return {
          state: state,
          balance: data[1]
        }
      else
        return {
          state: state
        }
      end
    end

    def method_missing(method, **args)
      args[:action] = method.to_s.camelize
      request(args)
    end
  end
end