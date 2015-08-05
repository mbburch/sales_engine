require_relative 'test_helper'
require './lib/customer_loader'
require './lib/customer_repository'

class CustomerLoaderTest < Minitest::Test

  def test_loading_customers_manually
    customer_repository = CustomerRepository.new
    customer_repository.customer_loader.add_customer("1",
                                                    "Joey",
                                                    "Ondricka",
                                                    "2012-03-27 14:54:09 UTC",
                                                    "2012-03-27 14:54:09 UTC")
    assert customer_repository.customers["1"]
  end

  def test_returning_name_from_repository_hash
    customer_repository = CustomerRepository.new
    customer_loader = customer_repository.customer_loader
    customer_loader.add_customer("1",
                                "Joey",
                                "Ondricka",
                                "2012-03-27 14:54:09 UTC",
                                "2012-03-27 14:54:09 UTC")
    result = customer_loader.customer_repository.customers["1"].first_name
    assert_equal "Joey", result
  end

  def test_that_csv_values_are_imported_from_fixture_file
    customer_repository = CustomerRepository.new('./fixtures/customers.csv')
    assert_equal customer_repository.customers,
    customer_repository.customer_loader.load_customers
  end

  def test_accessing_fixture_values
    customer_repository = CustomerRepository.new('./fixtures/customers.csv')
    customer_repository.customer_loader.load_customers
    assert_equal "Quinton", customer_repository.customers["98"].first_name
  end

  def test_that_csv_values_are_imported_from_real_csv_file
    customer_repository = CustomerRepository.new
    assert_equal customer_repository.customers,
    customer_repository.customer_loader.load_customers
  end

  def test_accessing_values_from_full_csv_file
    customer_repository = CustomerRepository.new
    customer_repository.customer_loader.load_customers
    assert_equal "Samanta", customer_repository.customers["120"].first_name
  end

end
