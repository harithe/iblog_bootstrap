class Article < ActiveRecord::Base
  attr_accessible :name, :content, :published, :tag_list

  default_scope :order => 'created_at DESC'

  acts_as_taggable

  has_many :comments

  validates :name, :presence => true

  scope :recent, Article.where( :published => true ).limit(5)
  scope :published, Article.where( :published => true )
  scope :unpublished, Article.where(:published => false)

  def to_param 
    "#{id}-#{name.gsub(/\s|(,)/, '-')}.html"
  end
end
