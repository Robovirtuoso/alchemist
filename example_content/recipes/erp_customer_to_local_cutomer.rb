Alchemist::RecipeBook.write ErpCustomer, LocalCustomer do

  result {
    LocalCustomer.new
  }

  source_method :name do |name|
    self.first_name, self.last_name = *name.split(' ')
  end

  transfer :email_address, :email

  source_method :event_log do |event_log|
    user_events = event_log.map do |event|
      Alchemist.transmute(event, UserEvent)
    end

    self.user_events.concat(user_events)
  end

end
