class Message < ActiveRecord::Base
  has_many :comments
   validates_presence_of :body
end
