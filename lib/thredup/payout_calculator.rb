module Thredup
  class PayoutCalculator
    def self.calculate_total(db, items)
      total = 0
      items.each do |item|
        brand_multiplier = db.find_brand(item[:brand])[:payout_multiplier]
        cat_multiplier = db.find_category(item[:category])[:payout_multiplier]
        total += calculate(brand_multiplier, cat_multiplier)
      end
      total
    end

    def self.calculate(brand_multiplier, category_multiplier)
      (1 * brand_multiplier * category_multiplier)
    end
  end
end
