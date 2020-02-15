class Customer < ApplicationRecord
  enum registry_type: {
    CPF: 0,
    CNPJ: 1,
  }

  validate :validate_national_registry_code
 
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

end
