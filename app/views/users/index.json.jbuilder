json.array!(@users) do |user|
  json.extract! user, :slug
end
