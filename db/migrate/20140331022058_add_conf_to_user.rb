class AddConfToUser < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end
 
  def change
    add_column :users, :confirmed_at, :datetime
    User.reset_column_information
    
       
    
  end
end