class User < ApplicationRecord
    include Devise::JWT::RevocationStrategies::JTIMatcher
    include Filterable
    has_secure_password

    validates_format_of :email,:with => Devise::email_regexp
    validates :username, :first_name, :last_name,  presence: true
    validates :username, uniqueness: true
    validates_length_of :password, :within => 4..25, :on => :create
    # validates :contact_no, :presence => true, :numericality => true, :length => { :minimum => 10}
    
    attr_accessor :password
    attr_writer :login

    def login
        @login || self.username || self.email
    end

    has_logidze
    acts_as_paranoid
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable,
            :jwt_authenticatable, jwt_revocation_strategy: self, authentication_keys: [:login]

    belongs_to :role
    has_many :accounts , dependent: :destroy  
    has_many :transactions

    def full_name
        "#{first_name} #{last_name}".split.map(&:capitalize).join(' ')
    end
  
    def jwt_payload
	  super.merge({ "user_id" => self.id, roles: self.roles.collect(&:code) })
    end
end
