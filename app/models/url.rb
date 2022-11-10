class Url < ApplicationRecord
  # -------------------------- Validations -------------------------------
  validates :original, presence: true,
                       uniqueness: true,
                       format: { with: /[https:\/\/]/, message: 'Format is not allowed.' }

  # TODO: validate if random_id duplicated

  # -------------------------- Callbacks ---------------------------------
  before_create :generate_random_id
  after_create :add_into_cache_list
  after_destroy :remove_form_cache_list


  def generate_random_id
    self.random_id = SecureRandom.uuid[0..5]
  end

  def add_into_cache_list
    Rails.cache.write("url_cache_key_#{random_id}", self.original)
  end

  def remove_form_cache_list
    Rails.cache.delete("url_cache_key_#{random_id}")
  end
end
