require 'image_categories'
require 'securerandom'

class ProcessableImage
  attr_reader :original_filename, :new_filename, :categories

  def initialize(filename)
    @original_filename = filename
    @categories = [File.basename(File.expand_path("..", filename))]
    @new_filename = generate_unique_filename
  end

  def add_category(category)
    @categories << category unless @categories.include?(category)
  end

  def original_base_filename
    File.basename @original_filename
  end

  private

  def generate_unique_filename
    output_path + "/" + SecureRandom.uuid + ".jpg"
  end

  def output_path
    AppConfig.config.output_path
  end
end