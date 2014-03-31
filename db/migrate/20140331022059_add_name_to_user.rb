class AddNameToUser < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end
 
  def change
    add_column :users, :name, :string
    User.reset_column_information
    reversible do |dir|
      dir.up { User.update_all name: "" }
    end
  end
end