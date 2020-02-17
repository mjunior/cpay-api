class Customer < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :national_registry_code, presence: true, uniqueness: true
  has_one :wallet

  enum registry_type: {
    CPF: 0,
    CNPJ: 1,
  }

  validate :validate_national_registry_code

  def self.from_token_request request
    national_registry_code = request.params["auth"] && request.params["auth"]["national_registry_code"]
    customer = self.find_by national_registry_code: national_registry_code
    customer
  end

  def validate_national_registry_code
    if self.registry_type == 0 || self.registry_type === 'CPF' 
      check_cpf 
    else
      check_cnpj
    end
  end

  def check_cpf
    unless CPF.valid?(self.national_registry_code)
      errors.add(:national_registry_code, 'CPF Invalido')
    end   
  end

  def check_cnpj
    unless CNPJ.valid?(self.national_registry_code)
      errors.add(:national_registry_code, 'CNPJ Invalido')
    end   
  end

  def balance
    self.wallet?.balance
  end

end
