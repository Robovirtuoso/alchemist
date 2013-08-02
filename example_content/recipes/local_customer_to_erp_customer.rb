Alchemist::RecipeBook.write LocalCustomer, ErpCustomer do

  result do |source|
    ErpCustomer.new
  end

  transfer :order_count, :orders do |order_count|
    order_count.to_s
  end

  transfer :email, :email_address

  # TODO(jchristie+robovirtuoso) Implement this new ritual, possibly with a
  # better name
  # alter_member :user_events, :event_log do |member, user_events|
  #   'member' inside this block is the Array of EventLog objects without an
  #   accessor on ErpCustomer
  #
  #   member = result.public_send(result_method)
  #   block.call(member, source_value)
  # end

end
