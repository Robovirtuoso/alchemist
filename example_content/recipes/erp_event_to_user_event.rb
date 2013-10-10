require 'time'

Alchemist::RecipeBook.write ErpEvent, UserEvent do

  result {
    UserEvent.new
  }

  transfer :name, :type

  source_method :datetime do |datetime|
    date = Date.parse(datetime.split(' ', 2).first)
    time = Time.parse(datetime)

    self.date = date
    self.time = time
  end

end
