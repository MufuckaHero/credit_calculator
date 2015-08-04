require "sinatra"
require_relative 'credit_calculator'

not_found do
  status 404
  "Something wrong! Try to type URL correctly or call to UFO."
end

get '/' do
  erb :index
end

post '/calculate' do
  if params[:percent].to_i <= 0 || params[:credit].to_i <= 0 || params[:term].to_i <= 0
    "Введені значення повинні бути більше 0!"
  else
    @result = 
      if params[:payOff] == "Usual"
        CreditCalculator.new(params[:percent], params[:credit],params[:term])
      else
        Acredit.new(params[:percent], params[:credit],params[:term])
      end
 
    @result.calculate
    erb :calculate
  end
end  
