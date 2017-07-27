require_relative './store'

class SimpleWarehouse
  def run
    @live = true
    @store = nil
    puts 'Type `help` for instructions on usage'
    while @live
      print '> '
      args = gets.chomp.split ' '
      command = args.shift

      play_turn command, args
    end
  end

  def play_turn(command, args)
    case command
      when 'init'
        return show_unrecognized_message if !args[0] || !args[1]

        width, height = *args
        @store = Store.new width, height
        puts "Store initiated with a table of #{width} x #{height}"
      when 'store'
        return show_not_initiated if @store.nil?

        begin
          @store.store(*args)
          puts 'Product successfully saved.'
        rescue Exception => e
          show_invalid_message(e.message)
        end
      when 'remove'
        return show_not_initiated if @store.nil?

        begin
          @store.remove(*args)
          puts "Crate successfully removed!"
        rescue Exception => e
          show_invalid_message(e.message)
        end
      when 'locate'
        return show_not_initiated if @store.nil?

        found = @store.locate *args
        if found.size > 0
          puts "Product #{args[0]} found in: ", found.map { |f| f.join ', ' }
        else
          puts "No product found of type #{args[0]}"
        end
      when 'help'
        show_help_message
      when 'view'
        return show_not_initiated if @store.nil?

        @store.view
      when 'exit'
        exit
      else
        show_unrecognized_message
    end
  end

  private

  def show_help_message
    puts 'help             Shows this help message
init W H         (Re)Initialises the application as a W x H warehouse, with all spaces empty.
store X Y W H P  Stores a crate of product number P and of size W x H at position X,Y.
locate P         Show a list of positions where product number can be found.
remove X Y       Remove the crate at positon X,Y.
view             Show a representation of the current state of the warehouse, marking each position as filled or empty.
exit             Exits the application.'
  end

  def show_not_initiated
    show_invalid_message('No store initiated.')
  end
  def show_invalid_message(error = nil)
    puts error || 'Sorry there was an error.'
  end

  def show_unrecognized_message
    puts 'Command not found. Type `help` for instructions on usage'
  end

  def exit
    puts 'Thank you for using simple_warehouse!'
    @live = false
  end

end
