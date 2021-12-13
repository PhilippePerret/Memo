# encoding: UTF-8
# frozen_litteral_string: true
require_relative 'MemoClass'

class Mail < MemoClass
class << self


  def data_path
    @data_path ||= File.join(DATA_FOLDER,'mail.yaml')
  end
end #/<< self

end #/Mail
