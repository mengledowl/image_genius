require 'singleton'

class AppConfig
  include Singleton

  attr_accessor :input_path, :output_path, :resize

  def self.configuration(&block)
    yield(self.instance)
  end

  def self.config
    self.instance
  end

  def version
    '0.1.0'
  end

  def input_path
    @input_path ||= "../../Pictures/sample-images/"
  end

  def output_path
    @output_path ||= "output/images"
  end

  def resize
    @resize ||= "400x300"
  end
end