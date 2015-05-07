class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :sender
      t.text :cipher
      t.integer :iv
      t.string :key_recipient_enc
      t.text :sig_recipient
      t.timestamp :timestamp
      t.string :recipient
      t.text :sig_service

      t.timestamps
    end
  end
end
