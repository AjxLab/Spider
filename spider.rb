# -*- coding: utf-8 -*-
Bundler.require
require './mail'


START_TIME = Time.new
URL = 'http://www.example.com/'


def crawl(delay: 3, depth_limit: nil, multi: false)
  ## -----*----- クローリング -----*----- ##
  # delay：Float --> アクセス間隔
  # depth_limit：Int --> クロールする深さ
  # multi：Bool --> 並列処理(true) or 逐次処理(false)

  # ターゲットURLを指定（Array）
  urls = [URL, URL, URL]
  pending = urls.length

  if multi
    # 並列処理 ==================================
    EM.run {
      urls.each { |url|
        agent = Husc.new(url)
        puts agent.code
        EM.stop_event_loop if (pending -= 1) < 1
      }
    }
  else
    # 逐次処理 ==================================
    mdap(pending) do |i|
      urls.each { |url|
        agent = Husc.new(url)
      }
    end
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

  exit status
end



if __FILE__ == $0
  crawl
  footer_exit
end

