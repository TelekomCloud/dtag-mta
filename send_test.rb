#!/usr/bin/env ruby
require 'net/smtp'

message = <<MESSAGE_END
From: Luke <luke@go.away>
To: Domi <do.richter@telekom.de>
Subject: The force

... is with you
MESSAGE_END

Net::SMTP.start('localhost',8025) do |smtp|
  smtp.send_message message, 'luke@go.away', 
                             'do.richter@telekom.de'
end
