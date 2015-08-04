class MerchantLoader

  attr_reader :merchant_repository

  def initialize(merchant_repository)
    @merchant_repository = merchant_repository
  end

  def add_merchant(id, name, created_at, updated_at)
    merchant_repository.merchants[id] = Merchant.new(id, name, created_at, updated_at)
  end

  def load_merchants
    CSV.foreach('./data/merchants.csv',
                headers: true,
                header_converters: :symbol) do |row|
      add_merchant(row[:id], row[:name], row[:created_at], row[:updated_at])
    end
    merchant_repository.merchants
  end

end
