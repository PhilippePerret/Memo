#!/usr/bin/env ruby
# encoding: UTF-8
# frozen_litteral_string: true

require_relative 'xlib/required'

choix = Q.select("Obtenir ou définir :") do |q|
  q.choices [
    {name:"Mail", value: :mail},
    {name:"URL",  value: :url},
    {name:"Renoncer", value: nil}
  ]
  q.per_page 3
end

puts choix
