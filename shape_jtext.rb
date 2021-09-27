#!/usr/local/bin/ruby
#-*- encoding: utf-8 -*-

#PDFのテキストをコピーして比較するための前処理
require 'optparse'

option=Hash.new
OptionParser.new do |opt|
  opt.on('-w', '空白削除')   {|v| option[:white_space] = v}
  opt.parse(ARGV)
end

body=STDIN.read
body.split(/[\r\n]+/).each{|line|
  line.split(/。/).each{|s|
    s=s.gsub(/[\s　]+/,"") if option[:white_space]
    s=s.gsub(/[\(（]\s*([^）\)]*[^）\)\s])\s*[\)）]/,"\n"+'(\1)')
    s=s.gsub(/\[\s*([^\[]*[^\]\s])\s*\]/,"\n"+'[\1]')
    s=s.gsub(/\<\s*([^\<]*[^\>\s])\s*\>/,"\n"+'<\1>')
    s=s.gsub(/\【\s*([^【]*[^】\s])\s*】/,'【\1】')
    print "#{s.to_s.strip}\n"
  }
}
