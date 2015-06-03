require 'sinatra'
require 'twilio-ruby'

get '/' do
	Twilio::TwiML::Response.new do |r|
  	r.Gather :numDigits => '1', :action => '/handle-gather', :method => 'get' do |g|
  		g.Say 'You have reached Optimum Anesthesia. For requests for proposals or sales, press 1. For all other inquires, press 2. To hear this message again, press 9.'
  	end
  end
end

get '/handle-gather' do
	redirect '/' unless params['Digits'] == ('1' || '2')
	Twilio::TwiML::Response.new do |r|
		r.Say 'Please wait while we connect you.'
		if params['Digits'] == '1'
			r.Dial '+13305197372', :record => 'record-from-start'#, :action => '/send-recording.php'
		elsif params['Digits'] == '2'
			r.Dial '+13302865330', :record => 'record-from-start'#, :action => '/send-recording.php'
		end
	end
end
