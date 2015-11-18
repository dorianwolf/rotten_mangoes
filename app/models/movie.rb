class Movie < ActiveRecord::Base

  has_many :reviews

  validates :title, :director, :description, :release_date, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validate :release_date_is_in_the_past

  mount_uploader :image, ImageUploader

  scope :title, -> (text) { where 'title like ?', text}
  scope :title_and_director, -> (tit, dir) {title(tit).where('director like ?', dir)}

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size > 0
  end

  def self.runtime_in_range(min)
    max = 90 if min == 0
    max = 120 if min == 90
    max = 9999 if min == 120 or min == -1
    where('runtime_in_minutes >= ? and runtime_in_minutes < ?', min, max)
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end
