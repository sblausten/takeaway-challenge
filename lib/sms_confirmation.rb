require 'twilio-ruby'
require 'sinatra'
require 'active_support'


class SmsConfirmation

	def send
		account_sid = ENV['TWILIO_ACCOUNT_SID']
		auth_token = ENV['TWILIO_AUTH_TOKEN']
		time = Time.now + 1200
		client = Twilio::REST::Client.new(account_sid, auth_token)

		client.account.messages.create(
		  from: ENV['TWILIO_PHONE'],
		  to: ENV['TWILIO_DESTINATION_PHONE'],
		  body: 'Thanks for your order. It will be delivered before #{time}.'
		)
	end

end
