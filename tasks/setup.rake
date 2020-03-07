# -*- coding:utf-8 -*-
require 'io/console'
require 'yaml'


def getpass(prompt:["id", "password"], is_echo:[true, false],
            display_tail: true, sub_char:"*")
  ## -----*----- パスワード入力 -----*----- ##
  raise ArgumentError unless prompt.length == is_echo.length
  ret = Array.new(prompt.length)

  prompt.length.times do |i|
    print "#{prompt[i]}："
    ret[i] = ''

    # エコーバック無し
    STDIN.noecho {
      i_backspace = 0

      loop do
        c = STDIN.raw(&:getc)
        # 改行
        break if c == "\r"

        ret[i] += c
        if is_echo[i]
          putc c
        else
          if display_tail
            # 末尾のみ表示・その他はsub_charに置換
            sub_str = sub_char * (ret[i].length-1) + ret[i][-1]
            print "\e[#{ret[i].length}D#{sub_str}\e[1C"
          else
            putc sub_char
          end
        end
      end
    }
    print "\n"
  end

  ret
end


namespace :setup do
  desc 'Gmail Settings'
  task :gmail do
    account = getpass(prompt: ["Gmail Address", "Application Password"])
    data = {'address'=> account[0], 'password'=> account[1]}
    YAML.dump(data, File.open('.mail.yml', 'w'))
  end
end
