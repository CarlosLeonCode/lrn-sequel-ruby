Sequel.migration do
  change do
    create_table :stages do
      primary_key :id
      foreign_key :festival_id
      String :name
      String :music_genre
    end
  end
end
