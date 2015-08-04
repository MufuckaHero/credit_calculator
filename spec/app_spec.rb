require File.expand_path '../spec_helper.rb', __FILE__

describe "GET '/'" do
  it "loads homepage" do
    get '/'
    expect(last_response).to be_ok
  end

  it "displays hompage content" do
    get '/'
    expect(last_response.body).to include("Процентна ставка(%):")
  end
end

describe "POST '/calculate'" do
  it "displays calculate template if params are > 0" do
    post '/calculate', percent: '12', credit: '10000', term: '6'
    expect(last_response.body).to include("погашення кредиту")
  end

  it "renders invalid value if params are <= 0" do
    post '/calculate', percent: '0', credit: '10000', term: '6'
    expect(last_response.body).to include("Введені значення повинні бути більше 0!")
  end  
end

describe CreditCalculator do
  describe ".calculate" do
    before do
      @result = CreditCalculator.new(15, 10000, 12)
      @result.calculate
    end

    it "returns arrays with values" do
      expect(@result.month_percent.any?).to be true
      expect(@result.credit.any?).to be true
      expect(@result.all_payment.any?).to be true
      expect(@result.payment.one?).to be true
    end

    it "divides initial credit on term" do
      expect(@result.payment.first.round(2)).to eq(833.33)
    end
  end
end                                                                                      

describe Acredit do
  describe ".calculate" do
    before do
      @result = Acredit.new(15, 10000, 12)
      @result.calculate
    end

    it "returns arrays with values" do
      expect(@result.month_percent.any?).to be true
      expect(@result.credit.any?).to be true
      expect(@result.all_payment.one?).to be true
      expect(@result.payment.any?).to be true
    end

    it "divides initial credit on term" do
      expect(@result.all_payment.first.round(2)).to eq(902.58)
    end
  end
end          