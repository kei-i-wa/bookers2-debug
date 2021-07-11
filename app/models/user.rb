class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books

  # belongs_to :books
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  has_many :reverse_of_relationships, class_name: "Relationship",foreign_key:"followed_id",dependent: :destroy
  has_many :relationships, class_name:"Relationship",foreign_key:"follower_id",dependent: :destroy
  has_many :followers,through: :reverse_of_relationships,source: :follower
  has_many:followings,through: :relationships,source: :followed
  
  
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  has_many :group_users
  has_many :groups, through: :group_users
  
  def follow(user_id)
    # relationships.create(followed_id:user_id)でもおk
    relationship=relationships.new(followed_id: user_id)
    relationship.save
  end
  
  def unfolloe(user_id)
    relationships.find_by(followed_id:user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
  
end
