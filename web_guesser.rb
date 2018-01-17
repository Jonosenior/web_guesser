require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  # render the ERB template named index and create a local variable for the template named number which has the same value as the number variable from this server code."
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
  # throw params.inspect
end

def check_guess(guess)
  if guess > SECRET_NUMBER
    if (guess - SECRET_NUMBER) > 15
      return "Way too high!"
    else
      return "Too high!"
    end
  elsif SECRET_NUMBER > guess
    if SECRET_NUMBER - guess > 15
      return "Way too low!"
    else
      return "Too low!"
    end
  elsif SECRET_NUMBER == guess
    return "Correct!\n\n The SECRET NUMBER is #{SECRET_NUMBER}"
  end
end
