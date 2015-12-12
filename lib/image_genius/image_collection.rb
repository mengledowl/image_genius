require 'mini_magick'

class ImageCollection
  include Enumerable

  attr_reader :collection

  def initialize
    @collection = []
  end

  def <<(processable_image)
    existing_image = find_image(processable_image)

    if existing_image
      existing_image.add_category(processable_image.categories.first)
    else
      @collection << processable_image
    end

    @collection
  end

  def find_image(processable_image)
    @collection.find { |image| image.original_base_filename == processable_image.original_base_filename }
  end

  def process_and_save
    set_up_output_directory
    output_path = AppConfig.config.output_path

    @collection.each_with_index do |image, index|
      new_image_path = "#{output_path}/#{index}.jpg"

      FileUtils.cp image.original_filename, new_image_path

      new_image = MiniMagick::Image.open(image.original_filename)
      new_image.resize "300x300"
      new_image.format "jpg"

      image.categories.each do |category|
        category_directory = "#{output_path}/#{category}"
        Dir.mkdir category_directory unless File.directory? category_directory

        new_image.write("#{category_directory}/#{File.basename(new_image_path)}")
      end
    end
  end

  def size
    @collection.size
  end

  def present?
    size > 0
  end

  private

  def set_up_output_directory
    verify_or_create_directory AppConfig.config.output_path
  end

  def verify_or_create_directory(path)
    return if File.directory? path
    return if path.length == 0

    directories = path.split('/')
    remove = directories.pop
    directories.delete(remove)

    new_path = directories.join('/')
    verify_or_create_directory(new_path)

    puts "creating directory:  #{path}"

    Dir.mkdir(path)
  end
end