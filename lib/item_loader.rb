require_relative 'item'
require 'CSV'

class ItemLoader

  attr_reader :item_repository

  def initialize(item_repository)
    @item_repository = item_repository
  end

  def add_item(name, description, unit_price, merchant_id, created_at, updated_at)

    item_repository.items[merchant_id] = Item.new(name, description, unit_price, merchant_id, created_at, updated_at)
  end

  def load_items
    CSV.foreach('./data/items.csv',
                headers: true,
                header_converters: :symbol) do |row|
      add_item(row[:name],
               row[:description],
               row[:unit_price],
               row[:merchant_id],
               row[:created_at],
               row[:updated_at])
    end
    item_repository.items
  end

end