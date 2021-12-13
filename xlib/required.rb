# encoding: UTF-8
# frozen_litteral_string: true
require 'yaml'
require 'tty-prompt'
Q = TTY::Prompt.new(symbols: {radio_on:"☒", radio_off:"☐"}) # cross : essai pour utiliser disabled dans les listes pour des sous-titres

require_relative 'constants'
require_relative 'String_CLI'
require_relative 'utils'
require_relative 'Url'
require_relative 'Mail'
