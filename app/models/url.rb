class Url < ApplicationRecord
  validates :original, presence: true,
                       uniqueness: true
                       format: { with: /[https:\/\/]/, message: 'Format is not allowed.' }
end
