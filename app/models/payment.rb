class Payment < ApplicationRecord
  attr_accessor :credit_card_numer, :credit_card_exp_month, :credit_card_exp_year, :credit_card_cvv
  belongs_to :order
  before_validation :create_on_stripe

  def create_on_stripe
    token=get_token
    params={
        amount: order.amount_cents,
        currencey: 'usd',
        source: token
    }
    response = Stripe::Charge.create(params)
    self.stripe_id=response.id
  end
  
  def get_token
    Stripe::Token.create({
      card: {
        number: credit_card_numer,
        exp_month: credit_card_exp_month,
        exp_year: credit_card_exp_year,
        cvc: credit_card_cvv
      }
    })
  end
end
