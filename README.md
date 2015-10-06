# SmsAreaApi

A Ruby wrapper for sms-area.org API. 
Documentation for API is here: http://sms-area.org/api.txt

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sms_area_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sms_area_api

## Usage

``` ruby
# create a client
sms_area = SmsAreaApi::Client.new('1111111111111111111111')

# use snake_case instead of camelCase
sms_area.get_balance
# => {:state=>"ACCESS_BALANCE", :balance=>"26.5"}

# request a number
number = sms_area.get_number country: 'or', service: 'gm', count: 1
# => {:state=>"ACCESS_NUMBER", :id=>"111111", :access_number=>"12223334444"}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sms_area_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
