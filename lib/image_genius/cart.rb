require_relative 'image_collection'
require_relative 'processable_image'
require_relative 'app_config'
require_relative '../../config/config'

class Cart

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