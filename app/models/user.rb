class User < ApplicationRecord
  rolify
  PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
    /x
  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :lockable
  validates :mobile_number,:presence => true,
                  :numericality => true,
                  :length => { :minimum => 10, :maximum => 15 }
  
  validates :password, 
    presence: true, 
    length: { in: Devise.password_length }, 
    format: { with: PASSWORD_FORMAT }, 
    confirmation: true, 
    on: :create 
  
  validates :password, 
    allow_nil: true, 
    length: { in: Devise.password_length }, 
    format: { with: PASSWORD_FORMAT }, 
    confirmation: true, 
    on: :update

    after_create :assign_role 

    private 

    def assign_role 
      self.add_role(:customer)
    end
end
