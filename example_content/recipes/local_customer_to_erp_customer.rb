Alchemist::RecipeBook.write LocalCustomer, ErpCustomer do

  result do |source|
    ErpCustomer.new
  end

  transfer :order_count, :orders do |order_count|
    order_count.to_s
  end

  transfer :email, :email_address

end
