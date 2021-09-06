class CreateTwitterAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :twitter_accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.string :username
      t.string :image
      t.string :secret
      t.string :token

      t.timestamps
    end
  end
end
