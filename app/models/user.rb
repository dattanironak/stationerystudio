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
         :confirmable, :lockable, :omniauthable, omniauth_providers: [:google_oauth2]


  validates :mobile_number,:presence => true,
                  :numericality => true,
                  :length => { :minimum => 10, :maximum => 15 },
                  if: :not_omniauth_user?
  
  validates :password, 
    presence: true,  
    format: { with: PASSWORD_FORMAT }, 
    confirmation: true, 
    on: :create
  
  validates :password, 
    format: { with: PASSWORD_FORMAT }, 
    confirmation: true, 
    on: :update


    after_create :assign_role 

    def self.from_google(u)
      create_with(uid: u[:uid], provider: 'google',
                  password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])
    end

    private 

    def assign_role 
      self.add_role(:customer)
    end

    def not_omniauth_user? 
      !self.provider?
    end

end
