require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'item_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'transaction'
require_relative 'transaction_repository'

class SalesEngine

  attr_reader :merchant_repository,
              :invoice_repository,
              :item_repository,
              :invoice_item_repository,
              :customer_repository,
              :transaction_repository

  def startup
    merchant_repository = MerchantRepository.new
    invoice_repository = InvoiceRepository.new
    item_repository = ItemRepository.new
    invoice_item_repository = InvoiceItemRepository.new
    customer_repository = CustomerRepository.new
    transaction_repository = TransactionRepository.new
  end

end