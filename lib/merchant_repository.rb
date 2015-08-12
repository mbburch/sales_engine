require_relative 'merchant'
require_relative 'merchant_loader'

class MerchantRepository

  attr_reader :merchants, :engine

  def initialize(engine = nil)
    @merchants = {}
    @engine = engine
  end

  def all
    merchants.values
  end

  def random
    merchants.values.to_a.sample
  end

  def find_by_id(id)
    merchants[id]
  end

  def find_by(attribute, match)
    found = merchants.detect do |id, object|
      object.send(attribute) == match
    end
    if found.nil?
      found = []
    else
      found = found.last
    end
  end

  def find_by_name(name)
    find_by(:name, name)
  end

  def find_by_created_at(created_at)
    find_by(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by(:updated_at, updated_at)
  end

  def find_by_all(attribute, match)
    found = merchants.select do |id, object|
      object.send(attribute) == match
    end
    found || empty = []
  end

  def find_all_by_id(id)
    find_by_all(:id, id)
  end

  def find_all_by_name(name)
    find_by_all(:name, name)
  end

  def find_all_by_created_at(created_at)
    find_by_all(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_by_all(:updated_at, updated_at)
  end

###########RELATIONSHIP METHODS##################

  def items(merchant_id)
    engine.items_by_merchant(merchant_id)
  end

  def invoices(merchant_id)
    engine.invoices_by_merchant(merchant_id)
  end

# B.I

  def revenue(merchant_id, date = nil)
    engine.revenue(merchant_id, date)
  end

  def favorite_customer(merchant_id)
    engine.favorite_customer(merchant_id)
  end

  def most_revenue(x)
    all_revenues = merchants.keys.collect do |merchant|
      revenue(merchant.id)
    end
    # sort all revenues from most to least
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
