class CreditCalculator 

  attr_accessor :payment, :month_percent, :all_payment, :credit

  def initialize(percent, credit, term)
    @percent = percent.to_f
    @credit = [credit.to_f]
    @term = term.to_i
  end

  def calculate
    @month_percent = []
    @all_payment = []
    @payment = [@credit.first / @term]

    @term.times do 
      @month_percent << @credit.last * 30 * @percent /  36000
      @all_payment << @payment.last + @month_percent.last
      @credit << @credit.last - @payment.last
    end
  end

end

class Acredit < CreditCalculator

  def calculate
    @payment = []
    @month_percent = []
    @percent_year = @percent / 100 / 12
    @all_payment = [@credit.first * ( @percent_year + ( @percent_year / ( ( 1 + @percent_year ) ** @term - 1 ) ) )]
    
    @term.times do
      @month_percent << @credit.last * @percent_year
      @payment << @all_payment.last - @month_percent.last
      @credit << @credit.last - @payment.last
    end
  end

end