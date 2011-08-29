#!/usr/bin/ruby1.9.1
# -*- coding: utf-8 -*-

def conv(str, title)
  state = :starting
  timedata = nil
  memdata = nil
  titledata = nil
  sourcedata = nil
  source_urldata = nil
  table_construct = ""
  ret = ""
  str.lines.each do |line|
    if state == :starting && /id="main"/ === line
      state = :started
      next
    end
    if state == :started && /^    <\/div>/ === line
      break
    end
    if state == :img
      if /<\/div>/ === line
        ret << "</div>\n\n"
        state = :started
        next
      end
      if /^ *(.*)$/ === line
        ret << "  #$1\n"
      end
    end
    if state == :table
      if /<\/table>/ === line
        table_construct.scan(/<tr>(.*?)<\/tr>/m) do
          tr = $1
          cells = []
          tr.scan(/<th>(.*?)<\/th>/m) do
            cells << "_. #$1"
          end
          tr.scan(/<td>(.*?)<\/td>/m) do
            cells << $1
          end
          cells = cells.collect{|s| s.gsub(/\n\n/, "\n").gsub(/pre/, "samp")}
          ret << "|#{cells.join("|")}|\n"
        end
        ret << "\n"
        state = :started
        next
      end
      table_construct << "#{line}\n"
    end
    if state == :ul
      if /<\/ul>/ === line
        ret << "\n"
        state = :started
        next
      end
      if /<li>(.*)<\/li>/ === line
        ret << "* #$1\n"
      end
    end
    if state != :started
      next
    end


    if /<p class="timemem">(.*)<\/p>/ === line
      val = $1
      if /([0-9.]+秒)/ === val
        timedata = $1
      end
      if /([0-9.]+MB)/ === val
        memdata = $1
      end
    elsif /<h1>(.*)\((.*)\)<\/h1>/ === line
      titledata = "#$2(#$1) - #{title}"
    elsif /<h1>(.*): (.*)<\/h1>/ === line
      titledata = "#$1(#$2) - #{title}"
    elsif /<p class="source">出典: <a href="(.*)">(.*)<\/a><\/p>/ === line
      sourcedata = $1
      source_urldata = $2
    elsif /<div class="img-tableau">/ === line
      state = :img
      ret << "<div class=\"img-tableau\">\n"
    elsif /<table.*>/ === line
      state = :table
      table_construct = ""
    elsif /<ul>/ === line
      state = :ul
    elsif /<p>(.*)<\/p>/ === line
      ret << "#$1\n\n"
    elsif /<h2>(.*)<\/h2>/ === line
      ret << "h2. #$1\n\n"
    end
  end
  ret0 = ""
  ret0 << "---\n"
  ret0 << "layout: default\n"
  ret0 << "title: #{titledata.inspect}\n"
  ret0 << "source: #{sourcedata.inspect}\n" if sourcedata
  ret0 << "source_url: #{source_urldata.inspect}\n" if source_urldata
  ret0 << "timelimit: #{timedata.inspect}\n" if timedata
  ret0 << "memlimit: #{memdata.inspect}\n" if memdata
  ret0 << "---\n\n"
  return ret0+ret
end

# print conv(ARGF.read)

dir1 = "/home/qnighy/informatics-olympiad"
dir2 = "/home/qnighy/Dropbox/Public/sptr/html"

Dir.new(dir2).each do|d|
  case d
  when /AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAjoi(....)-(day.)-(.*)-prob[.]html/
    (year,day,prob) = [$1,$2,$3]
    str = File.read("#{dir2}/joi#{year}-#{day}-#{prob}-prob.html")
    File.open("#{dir1}/joi#{year}-#{day}-#{prob}-problem.textile", "w") do|file|
      file.print(conv(str, "joi#{year}-#{day}"))
    end
  end
end
