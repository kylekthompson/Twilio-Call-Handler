require 'sinatra'
require 'twilio-ruby'

get '/optimum-voice' do
	Twilio::TwiML::Response.new do |r|
  	r.Gather :numDigits => '1', :action => '/optimum-voice-handle-gather', :method => 'get' do |g|
  		g.Say 'You have reached Optimum Anesthesia. For requests for proposals or sales, press 1. For all other inquiries, press 2. To hear this message again, press any other number.'
  	end
  end.text
end

get '/optimum-voice-handle-gather' do
	redirect '/optimum-voice' unless params['Digits'] == ('1' || '2')
	Twilio::TwiML::Response.new do |r|
		r.Say 'Please wait while we connect you.'
		if params['Digits'] == '1'
			r.Dial '+13307740777', :record => 'record-from-ringing', :action => 'https://www.kylekthompson.com/optimum/optimum-voice-send-recording.php'
		elsif params['Digits'] == '2'
			r.Dial '+13302865330', :record => 'record-from-ringing', :action => 'https://www.kylekthompson.com/optimum/optimum-voice-send-recording.php'
		end
	end.text
end
