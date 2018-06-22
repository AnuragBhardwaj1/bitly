# This model store links: (column: [:short_link, :long_link])
class Link < ActiveRecord::Base
  DEFAULT_LENGTH = 6    # taking  default lenght to 6 as it can take 6*64 unique values, and if collision occurs,
  EXTENDED_LENGTH = 10  # creating new hash using extended length for less collision probablity.

  validates :short_link, :long_link, presence: true
  # every short hash is validated for uniqueness at application level and added unique index at db level for race condition.
  validates :short_link, uniqueness: { case_sensitive: true }, allow_blank: true
  validate :long_link_format, on: :create

  before_validation :generate_short_link, :sanitize_long_link, on: :create

  def redirection_url
    redirection_url = URI.parse long_link
    redirection_url.scheme ? long_link : "http://#{ long_link }"
  end

  private

  def generate_short_link
    self.short_link = SecureRandom.urlsafe_base64 DEFAULT_LENGTH
    while Link.find_by(short_link: self.short_link)
      self.short_link = SecureRandom.urlsafe_base64 EXTENDED_LENGTH
    end
  end

  def long_link_format
    # doing a basic validation to check it does not include space.
    errors.add(:base, I18n.t(:invalid_url, scope: :link)) if !((long_link =~ URI::regexp) || (long_link =~ /^\S+$/))
  end

  def sanitize_long_link
    # basic sanitization: removing padded spacing
    long_link.strip! if long_link.present?
  end
end
