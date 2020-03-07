# -*- coding: utf-8 -*-
Bundler.require
require './mail'


START_TIME = Time.new


def footer_exit(status: 0)
  ## -----*----- EXIT -----*----- ##
  puts ""
  puts ""
  puts "----------------------------------------------------------------------"
  puts sprintf("Ran #{status} #{$0} in %5.3fs", Time.new - START_TIME)
  puts ""
  if status==0
    puts "\e[32mOK\e[0m"
  else
    puts "\e[31mERROR\e[0m"
  end

  exit status
end



if __FILE__ == $0
  #connect_gmail
  send_mail('abe12@mccc.jp', 'test', 'メール送信に成功')
  footer_exit
end

