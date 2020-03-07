# -*- coding: utf-8 -*-
Bundler.require


def connect_gmail(file: '.mail.yml')
  ## -----*----- Gmailアカウント -----*----- ##
  begin
    account = YAML.load_file(file)
  rescue => error
    puts "\e[31m#{error}\e[0m"
    puts 'Please set up gmail by executing the following command.'
    puts '$ bundle exec rake setup:gmail'

    footer_exit status: 1
  end

  ## Connect Gmail with Application Password
  $gmail = Gmail.new(account['address'], account['password'])
end


def send_mail(to_address, title, sentence)
  ## -----*----- メール送信 -----*----- ##
  # to_address；送信先のアドレス
  # title：メールタイトル
  # sentence：メール本文

  # Gmailオブジェクトが未生成
  connect_gmail unless defined? $gmail

  message =
    $gmail.generate_message do
      to to_address
      subject title
      html_part do
        content_type "text/html; charset=UTF-8"
        body sentence
      end
    end

  $gmail.deliver(message)
end


if __FILE__ == $0
  send_mail('abe12@mccc.jp', 'test', 'メール送信に成功')
end

