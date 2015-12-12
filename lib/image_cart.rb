lib = File.expand_path("../image_cart", __FILE__)
config = File.expand_path("../../config", __FILE__)

$:.unshift(lib)
$:.unshift(config)

require 'image_collection'
require 'processable_image'
require 'app_config'
require 'config'

class ImageCart

  attr_reader :images

  def initialize
    @images = ImageCollection.new
  end

  def build
    image_paths = Dir.glob("#{AppConfig.config.input_path}/**/*.jpg")

    image_paths.each do |path|
      @images << ProcessableImage.new(path)
    end
  end

  def process
    build unless @images.present?
    @images.process_and_save
  end
end