require_relative 'menu'

class Order
	attr_reader :dishes

	def initialize
		@dishes = []
		@bill = 0
		@menu = nil
	end

	def get_menu(number)
		raise ArgumentError, 'Not a valid menu number' unless number <= Menu.menus.length
		@menu = Menu.get_menu(number)
	end

	def get_dish(name, quantity)
		validate_dish(name.downcase, quantity)
		add_dish(name.downcase, quantity, (find_price(name)*quantity))
	end

	def print_orders
		@dishes.each { |order|
			puts "You've ordered #{order[:quantity]} #{order[:name].capitalize} at £#{find_price(order[:name])} each = #{order[:total]}"
		}
	end

	def calculate_total
		total = 0
		@dishes.each {|order|
			total += order[:total].to_i
		}
		total
	end

	private

	def validate_dish(name, quantity)
		raise ArgumentError, 'No menu selected' if @menu == nil
		raise ArgumentError, 'Not valid dish name' unless dish_exists?(name)
		raise ArgumentError, 'Quantity must be whole number' unless quantity.is_a? Integer
	end

	def dish_exists?(name)
		#return true if valid dish name for menu
		exists = false
		@menu.get_dishes.each { |dish|
			exists = true if dish[:name] == name.downcase
		}
		exists
	end

	def find_price(name)
		price = 0
		@menu.get_dishes.each { |dish|
			price = dish[:price] if dish[:name] == name.downcase
		}
		price.to_i
	end

	def add_dish(name, quantity, total_price)
		@dishes << {name: name, quantity: quantity, total: total_price}
	end

end
