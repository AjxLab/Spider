# -*- coding: utf-8 -*-
Bundler.require
require './mailer'


START_TIME = Time.new
URL = 'http://www.example.com/'
Log = Logger.new('develop.log')
Account = YAML.load_file('.mail.yml')


def crawl(delay: 3, depth_limit: nil, multi: false, exit_all: true, error_alert: true)
  ## -----*----- クローリング -----*----- ##
  # delay：Float --> アクセス間隔
  # depth_limit：Int --> クロールする深さ
  # multi：Bool --> 並列処理(true) or 逐次処理(false)
  # exit_all：Bool --> エラーが発生した場合に，全てのタスクを終了

  # ターゲットURLを指定（Array）
  urls = [URL, URL, URL, 'http://1028051', URL]

  task = Proc.new { |url|
    begin
      agent = Husc.new(url)

      # ==============
      # スクレイピング
      # ==============
    rescue => e
      Log.error("#{e}")
      send_mail(Account[:receive][:address], 'エラー発生', e.to_s)  if error_alert
      footer_exit(status: 1)  if exit_all
    end
  }

  if multi
    # 並列処理 ==================================
    threads = urls.map { |url|
      Thread.new {
        task.call(url)
      }
    }

    tw = ThreadsWait.new(*threads)
    mdap(urls.length) {tw.next_wait}
  else
    # 逐次処理 ==================================
    mdap(urls.length) { |i|
      task.call(urls[i])
    }
  end
end


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

  yield  if block_given?

  exit status
end



if __FILE__ == $0
  crawl(multi: true, exit_all: false)
  footer_exit
end

