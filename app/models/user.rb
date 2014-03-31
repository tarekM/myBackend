class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable,
         
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable,
		:confirmable 
		

	#before_save :ensure_authentication_token

	attr_accessible :name, :email, :password, :password_confirmation, :remember_me

	before_save :ensure_authentication_token

 
	def ensure_authentication_token
	    if authentication_token.blank?
	      self.authentication_token = generate_authentication_token
	    end
	end
	 
	private
	  
	def generate_authentication_token
	    loop do
	    token = Devise.friendly_token
	    break token unless User.where(authentication_token: token).first
	    end
	end
	#end
	def skip_confirmation
  		self.confirmed_at = Time.now
	end

	has_many :us_ss_relations, dependent: :destroy
	has_many :schedules, through: :us_ss_relations  #, order: [:day, :start_time]
	has_many :us_es_relations, dependent: :destroy
	has_many :events, through: :us_es_relations #, order: [:start_time, :end_time]

end
