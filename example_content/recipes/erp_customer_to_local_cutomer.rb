Alchemist::RecipeBook.write ErpCustomer, LocalCustomer do

  result do
    LocalCustomer.new
  end

  guard :required_field do |value|
    !value.nil?
  end

  assign :email_address, :email

  pass :name, :customer_name

  from_source :field_name do |field_value|

    assign_to :target_field

    pass_to :other_target_field do
      field_value.to_s
    end

  end

  source_attributes :field_one, :field_two do |attributes|

    condense_to :target_field do
      attributes[:default_quantity] + attributes[:other_quantity]
    end

    communicate_to :target_method do
      attributes.map { |key, value| value }
    end

  end

end
