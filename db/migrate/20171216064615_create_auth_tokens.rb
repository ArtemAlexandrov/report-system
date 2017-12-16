class CreateAuthTokens < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp'
    create_table :auth_tokens do |t|
      t.uuid :value, null: false, default: 'uuid_generate_v4()'
      t.datetime :expires_at
      t.references :user, foreign_key: {
          on_delete: :cascade
      }

      t.timestamps
    end
  end
end
