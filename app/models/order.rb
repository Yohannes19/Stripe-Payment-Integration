class Order < ApplicationRecord
  attr_accessor :credit_card_numer, :credit_card_exp_month, :credit_card_exp_year, :credit_card_cvv
  belongs_to :customer
  has_one :payment
  after_create :create_payment

  enum payment_method: i%[credit_card, paypal]
  def create_payment
    params  = {
      order_id: id,
      credit_card_numer:credit_card_numer,
      credit_card_exp_year: credit_card_exp_month,
      credit_card_exp_month: credit_card_exp_month,
      credit_card_cvv: credit_card_cvv
    }

    Payment.create!(params)

end
