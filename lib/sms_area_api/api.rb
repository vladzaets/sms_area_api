module SmsAreaApi
  class Client
    attr_accessor :api_key, :service

    @@service_endpoints = {
      'sms_area' => 'http://sms-area.org/stubs/handler_api.php',
      'sms_activate' => 'http://sms-activate.ru/stubs/handler_api.php'
    }

    def initialize(api_key, service = 'sms_area')
      self.api_key = api_key
      self.service = service
    end

    def service_endpoint
      @@service_endpoints[service]
    end

    def request(params)
      params[:api_key] = api_key
      response = RestClient.post self.service_endpoint, params
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