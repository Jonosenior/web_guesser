require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(100)
@@guesses_remaining = 6

get '/' do
  @@guesses_remaining -= 1
  guess = params["guess"].to_i
  cheat = params["cheat"]
  guess_status = return_guess_status(guess)
  message = set_message(guess_status)
  background_colour = set_background_colour(guess_status)
  message = message + "\n\n The secret number is #{@@secret_number}, you cheater" if cheat == "true"
  start_game if guess_status == :game_over || guess_status == :correct
  erb :index, :locals => {:number => @@secret_number, :message => message, :background_colour => background_colour, :guesses_remaining => @@guesses_remaining}
end

def start_game
   @@secret_number = rand(100)
   @@guesses_remaining = 6
end

def return_guess_status(guess)
  return :start if @@guesses_remaining == 5
  return :game_over if @@guesses_remaining == 0
  if guess > @@secret_number
    if (guess - @@secret_number) > 15
      return :way_high
    else
      return :high
    end
  elsif @@secret_number > guess
    if @@secret_number - guess > 15
      return :way_low
    else
      return :low
    end
  elsif @@secret_number == guess
    return :correct
  end
end

def set_background_colour(guess_status)
  background_colours = {:start => "white", :way_high => "crimson", :high => "coral", :correct => "forestgreen", :low => "coral", :way_low => "crimson", :game_over => "slategray"}
  background_colours[guess_status]
end

def set_message(guess_status)
  messages = {
    :start => "Good luck!",
    :way_high => "Way too high!",
    :high => "Too high!",
    :correct => "Correct!\n\n The secret number is #{@@secret_number}.",
    :low => "Too low!",
    :way_low => "Way too low!",
    :game_over => "You're out of guesses!\n\n The secret number was #{@@secret_number}."
  }
  messages[guess_status]
end
