# encoding: UTF-8
# frozen_litteral_string: true
require_relative 'MemoClass'

class Url < MemoClass
class << self

  def data_path
    @data_path ||= File.join(DATA_FOLDER,'url.yaml')
  end
end #/<< self

end #/Url
