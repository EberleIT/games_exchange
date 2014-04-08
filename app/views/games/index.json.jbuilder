json.array!(@games) do |game|
  json.extract! game, :game, :platform, :user_id
  json.url game_url(game, format: :json)
end