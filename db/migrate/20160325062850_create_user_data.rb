class CreateUserData < ActiveRecord::Migration
  def change
    create_table :user_informations do |t|
    	t.float :source_lat
      t.float :source_lng
      t.float :des_lat
      t.float :des_lng
      t.string :email, index: true
      t.datetime :time_to_reach
      t.float :kms, index: true
      t.boolean :email_sent, default: 0
      t.timestamps
    end
    add_index :user_informations, [:source_lat, :source_lng]
    add_index :user_informations, [:des_lat, :des_lng]
  end
end
