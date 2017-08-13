require 'sendgrid-ruby'
require 'sinatra'
require 'twilio-ruby'

get '/sms/optimum' do
  body = <<~BODY
    You have received a message from #{params['From']}.
    \n\n
    Body: #{params['Body']}
  BODY

  from = SendGrid::Email.new(email: 'webmaster@onlyoptimum.com')
  to = SendGrid::Email.new(email: 'christopher@onlyoptimum.com,kyle@kylekthompson.com')
  subject = 'Text Received! (Optimum Anesthesia Phone Service)'
  content = SendGrid::Content.new(type: 'text/plain', value: body)
  mail = SendGrid::Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  sg.client.mail._('send').post(request_body: mail.to_json)

  Twilio::TwiML::MessagingResponse.new do |r|
    r.message(body: 'Thank you for contacting Optimum Anesthesia. Your message has been received and is currently being processed.')
  end.to_s
end

get '/voice/optimum' do
  Twilio::TwiML::VoiceResponse.new do |r|
    r.gather(numDigits: '1', action: '/voice/optimum/handle_gather', method: 'get') do |g|
      g.say('You have reached Optimum Anesthesia.')
      g.say('For requests for proposals or sales, press 1. For all other inquiries, press 2.')
      g.say('To hear this message again, press any other number.')
    end
  end.to_s
end

get '/voice/optimum/handle_gather' do
  redirect '/voice/optimum' unless ['1', '2'].include?(params['Digits'])

  Twilio::TwiML::VoiceResponse.new do |r|
    r.say('Please wait while we connect you.')
    r.say('Please note that this call will be recorded for quality assurance.')

    phone_number =
      if params['Digits'] == '1'
        '+13305388385'
      else
        '+13302865330'
      end

    r.dial(
      number: phone_number,
      record: 'record-from-ringing',
      action: '/voice/optimum/send_voice_recording'
    )
  end.to_s
end

post '/voice/optimum/send_voice_recording' do
  if params['RecordingUrl']
    body = <<~BODY
      You have received a recording of a phone call through your phone service.
      \n\n
      From: #{params['From']}\n
      Duration: #{params['DialCallDuration']} seconds\n
      Recording URL: #{params['RecordingUrl']}.mp3\n
    BODY

    from = SendGrid::Email.new(email: 'webmaster@onlyoptimum.com')
    to = SendGrid::Email.new(email: 'christopher@onlyoptimum.com,kyle@kylekthompson.com')
    subject = 'Recording Received! (Optimum Anesthesia Phone Service)'
    content = SendGrid::Content.new(type: 'text/plain', value: body)
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.client.mail._('send').post(request_body: mail.to_json)
  end

  Twilio::TwiML::VoiceResponse.new do |r|
    r.hangup
  end.to_s
end

get '/sms/mvas' do
  body = <<~BODY
    You have received a message from #{params['From']}.
    \n\n
    Body: #{params['Body']}
  BODY

  from = SendGrid::Email.new(email: 'webmaster@onlyoptimum.com')
  to = SendGrid::Email.new(email: 'christopher@onlyoptimum.com,kyle@kylekthompson.com')
  subject = 'Text Received! (MVAS Phone Service)'
  content = SendGrid::Content.new(type: 'text/plain', value: body)
  mail = SendGrid::Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  sg.client.mail._('send').post(request_body: mail.to_json)

  Twilio::TwiML::MessagingResponse.new do |r|
    r.message(body: 'Thank you for contacting Mahoning Valley Anesthesia Services. Your message has been received and is currently being processed.')
  end.to_s
end

get '/voice/mvas' do
  Twilio::TwiML::VoiceResponse.new do |r|
    r.gather(numDigits: '1', action: '/voice/mvas/handle_gather', method: 'get') do |g|
      g.say('You have reached Mahoning Valley Anesthesia Services.')
      g.say('For requests for proposals or sales, press 1. For all other inquiries, press 2.')
      g.say('To hear this message again, press any other number.')
    end
  end.to_s
end

get '/voice/mvas/handle_gather' do
  redirect '/voice/mvas' unless ['1', '2'].include?(params['Digits'])

  Twilio::TwiML::VoiceResponse.new do |r|
    r.say('Please wait while we connect you.')
    r.say('Please note that this call will be recorded for quality assurance.')

    phone_number =
      if params['Digits'] == '1'
        '+13305197372'
      else
        '+13302865330'
      end

    r.dial(
      number: phone_number,
      record: 'record-from-ringing',
      action: '/voice/mvas/send_voice_recording'
    )
  end.to_s
end

post '/voice/mvas/send_voice_recording' do
    body = <<~BODY
      You have received a recording of a phone call through your phone service.
      \n\n
      From: #{params['From']}\n
      Duration: #{params['DialCallDuration']} seconds\n
      Recording URL: #{params['RecordingUrl']}.mp3\n
    BODY

    from = SendGrid::Email.new(email: 'webmaster@mvasinc.com')
    to = SendGrid::Email.new(email: 'cthompson@mvasinc.com,kyle@kylekthompson.com')
    subject = 'Recording Received! (MVAS Phone Service)'
    content = SendGrid::Content.new(type: 'text/plain', value: body)
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.client.mail._('send').post(request_body: mail.to_json)
  end

  Twilio::TwiML::VoiceResponse.new do |r|
    r.hangup
  end.to_s
end
