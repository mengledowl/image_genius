class ImageCategories
  include Enumerable

  attr_reader :categories

  def initialize
    @categories ||= []
  end

  def <<(category)
    @categories << category unless @categories.include?(category)
  end
end