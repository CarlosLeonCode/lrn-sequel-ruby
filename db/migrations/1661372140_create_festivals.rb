Sequel.migration do
  change do
    create_table :music_festivals do
      primary_key :id
      String :name, null: false, unique: true
      String :country_location, null: false
      Integer :days
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
