#!/usr/bin/env ruby
# encoding: UTF-8
# frozen_litteral_string: true

require_relative 'xlib/required'

clear

choix = Q.select("Obtenir ou définir :") do |q|
  q.choices [
    {name:"URL",  value: :url},
    {name:"Mail", value: :mail},
    {name:"Renoncer", value: nil}
  ]
  q.per_page 3
end

case choix
when :mail then Mail.choose
when :url  then Url.choose
end
