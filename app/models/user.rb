class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites ,dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_one_attached:profile_image

  validates :name, presence: true
  validates :name,length: { minimum: 2 }
  validates :name,length: { maximum: 20 }
  validates :name, uniqueness: true
  validates :introduction,length: { maximum: 50 }



end
