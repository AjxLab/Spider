# -*- coding: utf-8 -*-
Bundler.require


START_TIME = Time.new


def connect_gmail(file: '.mail.yml')
  ## -----*----- Gmailアカウント -----*----- ##
  begin
    account = YAML.load_file(file)
  rescue => error
    puts "\e[31m#{error}\e[0m"
    puts 'Please set up gmail by executing the following command.'
    puts '$ bundle exec rake setup'

    footer_exit status: 1
  end
  username = ''
end


def footer_exit(status: 0)
  ## -----*----- EXIT -----*----- ##
  puts ""
  puts ""
  puts "----------------------------------------------------------------------"
  puts sprintf("Ran #{status} #{__FILE__} in %5.3fs", Time.new - START_TIME)
  puts ""
  if status==0
    puts "\e[32mOK\e[0m"
  else
    puts "\e[31mERROR\e[0m"
  end

  exit status
end



connect_gmail

