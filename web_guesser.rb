require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

get '/' do
  guess = params["guess"].to_i
  guess_status = check_guess(guess)
  message = set_message(guess_status)
  background_colour = set_background_colour(guess_status)
  # render the ERB template named index and create a local variable for the template named number which has the same value as the number variable from this server code."
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message, :background_colour => background_colour}
  # throw params.inspect
end

def check_guess(guess)
  if guess > SECRET_NUMBER
    if (guess - SECRET_NUMBER) > 15
      return :way_high
    else
      return :high
    end
  elsif SECRET_NUMBER > guess
    if SECRET_NUMBER - guess > 15
      return :way_low
    else
      return :low
    end
  elsif SECRET_NUMBER == guess
    return :correct
  end
end

def set_background_colour(guess_status)
  background_colours = {:way_high => "crimson", :high => "coral", :correct => "forestgreen", :low => "coral", :way_low => "crimson"}
  background_colours[guess_status]
end

def set_message(guess_status)
  messages = {
    :way_high => "Way too high!",
    :high => "Too high!",
    :correct => "Correct!\n\n The SECRET NUMBER is #{SECRET_NUMBER}",
    :low => "Too low!",
    :way_low => "Way too low!" }
  messages[guess_status]
end
