class Blog < ActiveRecord::Base 
    belongs_to :user 
    validates_presence_of :title, :content
end