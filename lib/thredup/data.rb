require 'csv'

module Thredup
  class Data
    def initialize
      @root_path = '../../../data/'
    end

    def category_exists?(name)
      find_category(name)
    end

    def brand_exists?(name)
      find_brand(name)
    end

    def find_category(name)
      categories.select { |c| c[:name] == name }.first
    end

    def find_brand(name)
      brands.select { |b| b[:name] == name }.first
    end

    def categories
      @categories ||= load_csv(File.expand_path(@root_path + 'categories.csv', __FILE__))
    end

    def brands
      @brands ||= load_csv(File.expand_path(root_path + 'brands.csv', __FILE__))
    end

    private
    def load_csv(path)
      CSV.read(path, 
               headers: true,
               header_converters: :symbol,
               converters: :all)
    end
  end
end
