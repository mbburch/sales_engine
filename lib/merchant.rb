class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repository

  def initialize(id = nil,
                name = nil,
                created_at = nil,
                updated_at = nil,
                merchant_repository = nil)
    @id                  = id
    @name                = name.to_s.delete("\"")
    @created_at          = created_at
    @updated_at          = updated_at
    @merchant_repository = merchant_repository
  end

  def items
    merchant_repository.items(id)
  end

  def invoices
    merchant_repository.invoices(id)
  end

  def revenue(date = nil)
    successful_items(date).reduce(0) do |sum, invoice_item|
      sum + (invoice_item.quantity.to_i * invoice_item.unit_price)
    end
  end

  def favorite_customer
    merchant_repository.favorite_customer(id)
  end

  def merchant_transactions
    invoices.map do |invoice|
      invoice.transactions
    end.flatten
  end

  def filter_successful_invoices
    merchant_transactions.select do |transaction|
      transaction.result == "success"
    end
  end

  def successful_invoices
    filter_successful_invoices.map do |transaction|
      transaction.invoice
    end
  end

  def filter_invoices_for_date(date = nil)
    if date
      successful_invoices.select do |invoice|
        same_date?(invoice, date)
      end
    else
      successful_invoices
    end
  end

  def same_date?(invoice, date)
    created_at = invoice.created_at[0..9]
    Date.parse(created_at) == date
  end

  def successful_items(date = nil)
    filter_invoices_for_date(date).map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def revenue(date = nil)
    successful_items(date).reduce(0) do |sum, invoice_item|
      sum + invoice_item.total_cost
    end
  end

############# TO COMPLETE

  def favorite_customer
    grouped = successful_invoices.group_by do |invoice|
      invoice.customer_id
    end
    sorted = grouped.values.sort_by {|array| array.size}
    best_customer = grouped.last.size
  end

end
