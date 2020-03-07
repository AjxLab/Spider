require 'open-uri'

def webDL(link, file)
  ## -----*----- Webからダウンロード -----*----- ##
  FileUtils.mkdir_p(File.dirname(file)) unless FileTest.exist?(File.dirname(file))
  begin
    open(file, 'wb') do |local_file|
      URI.open(link) do |web_file|
        local_file.write(web_file.read)
      end
    end

  rescue => e
    Log.error(e.to_s)
  end
end


def scraping(doc)
  ## -----*----- スクレイピング -----*----- ##

  # ====================
  # 処理を記述
  # ====================

end
