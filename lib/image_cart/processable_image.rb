require_relative 'image_categories'

class ProcessableImage
  attr_reader :original_filename, :categories

  def initialize(filename)
    @original_filename = filename
    @categories = [File.basename(File.expand_path("..", filename))]
  end

  def add_category(category)
    @categories << category unless @categories.include?(category)
  end

  def original_base_filename
    File.basename @original_filename
  end
end