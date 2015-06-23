require 'money'

module Thredup
  class Application
    def initialize
      puts "Welcome to the Thredup Payout Calculator!"
      @items, @db = [], Thredup::Data.new
      get_items_info
      show_total
    end

    private
    def show_total
      bag_total = Thredup::PayoutCalculator.calculate_total(@db, @items)
      I18n.enforce_available_locales = false
      puts "Your bag has a total value of: $#{Money.new(bag_total * 100, "USD")}"
    end

    def get_items_info
      item_number = 1
      until @finished 
        get_item_info(item_number)
        item_number += 1
      end
    end

    def get_item_info(item_number)
      brand = get_brand_for_item(item_number)
      if finished?(brand)
        @finished = true
        return
      end
      category = get_category_for_item(item_number)
      if finished?(category)
        @finished = true
        return
      end
      @items << { 
        brand: brand,
        category: category
      }
    end

    def get_brand_for_item(item_number)
      brand = prompt_for_input("What Brand for item #{item_number}?")
      return 'finish' if finished?(brand)
      unless @db.brand_exists?(brand)
        puts "Invalid Brand #{brand}!"
        get_brand_for_item(item_number)
      end
      brand
    end

    def get_category_for_item(item_number)
      category = prompt_for_input("What Category for item #{item_number}?")
      return 'finish' if finished?(category)
      unless @db.category_exists?(category)
        puts "Invalid Category #{category}!"
        get_category_for_item(item_number)
      end
      category 
    end


    def finished?(input)
      ['finish', 'finished', 'done'].include?(input.downcase)
    end

    def prompt_for_input(message)
      puts message
      get_input
    end

    def get_input
      STDIN.gets.chomp
    end
  end
end
