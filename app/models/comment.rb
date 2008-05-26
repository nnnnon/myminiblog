class Comment < ActiveRecord::Base
  belongs_to :message
end
