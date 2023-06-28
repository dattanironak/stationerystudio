class User < ApplicationRecord
  rolify
  PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
    /x

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :mobile_number, :presence => true,
                            :numericality => true,
                            :length => { :minimum => 10, :maximum => 15 },
                            if: :not_omniauth_user?

  validates :password, presence: true, format: { with: PASSWORD_FORMAT, message: "Not matching password format" }, confirmation: true, if: :not_omniauth_user?

  validates :password_confirmation, presence: true, if: :not_omniauth_user?

  after_create :assign_role

  def self.from_google(u)
    @user = find_by(email: u[:email])

    unless @user
      @password = generate_password_for_omniuser
      create(uid: u[:uid], provider: "google",
             password: @password, email: u[:email])
    else
      @user
    end
  end

  def self.generate_password_for_omniuser
    valid_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+'

    random_string = []
    random_string << valid_chars[rand(valid_chars.length)]
    random_string << valid_chars[rand(valid_chars.length)]
    random_string << valid_chars[rand(valid_chars.length)]
    random_string << valid_chars[rand(valid_chars.length)]

    # Generate the remaining random characters
    8.times do
      random_char = valid_chars[rand(valid_chars.length)]
      random_string << random_char
    end

    random_string.join
  end

  private

  def assign_role
    self.add_role(:customer)
  end

  def not_omniauth_user?
    !self.provider?
  end
end
