module SmsAreaApi
  class Client
    attr_accessor :api_key

    def initialize(api_key)
      self.api_key = api_key
    end

    def request(action, params)
      request_params = {
        action: action,
        api_key: api_key
      }.merge(params)

      response = RestClient.post 'http://sms-area.org/stubs/handler_api.php', request_params

      if response =~ /ACCESS_NUMBER:/
        data = response.split(':')
        return {
          state: data[0],
          id: data[1],
          access_number: data[2]
        }
      elsif response =~ /STATUS_OK:/
        data = response.split(':')
        return {
          state: data[0],
          code: data[1]
        }
      else
        return response
      end
    end

    def method_missing(method, **args)  
      request(method.to_s.camelize, args)
    end


    def self.start
   
    end
  end
end