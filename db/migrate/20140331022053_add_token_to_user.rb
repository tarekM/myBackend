class AddTokenToUser < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end
 
  def change
    add_column :users, :authentication_token, :string
    User.reset_column_information
    reversible do |dir|
      #dir.up { User.update_all authentication_token: "" }
    end
  end
end