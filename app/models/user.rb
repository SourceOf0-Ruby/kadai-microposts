class User < ApplicationRecord
  
  before_save { self.email.downcase! };
  
  validates :name, presence: true, length: { maximum: 50 };
  
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false };
  
  has_secure_password;
  
  has_many :microposts;
  
  # relationships（Relationshipモデル群内のuser）を経由してfollowを取得するfollowingsを定義
  has_many :relationships;
  has_many :followings, through: :relationships, source: :follow;
  
  # reverses_of_relationship（Relationshipモデル群内のfollow）を経由してuserを取得するfollowersを定義
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id';
  has_many :followers, through: :reverses_of_relationship, source: :user;
  
  
  # フォローする
  # @param other_user: 対象のユーザ
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id);
    end
  end
  
  # フォローを外す
  # @param other_user: 対象のユーザ
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id);
    relationship.destroy if relationship;
  end
  
  # フォローしているか確認する
  # @param other_user: 対象のユーザ
  # @return: フォローしていればtrue
  def following?(other_user)
    return self.followings.include?(other_user);
  end
  
end
