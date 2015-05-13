class User < ActiveRecord::Base
	has_one :profile
	has_many :posts
  end

class Profile < ActiveRecord::Base
	belongs_to :user
  end

class Gab < ActiveRecord::Base
	belongs_to :user
	has_many :users
  end
