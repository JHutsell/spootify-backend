Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      get 'auth', to: "sessions#create"
      post 'login', to: "users#create"

      get 'userPlaylists', to: "playlists#user_playlists"
    
      post 'createNewPlaylist/:name' , to: "playlists#make_new_playlist"

      resources :songs
      get 'recent', to: "songs#recent_songs"
      get 'topArtists', to: "songs#top_artists"
      get 'currentSong', to: "songs#current_song"
      post '/getSong/:term', to: "songs#searched_song"
      post '/postSong/:playlist_id/:song_uri', to: "songs#add_song_to_playlist"
      post '/getReccos/:song_1/:song_2/:song_3/:song_4/:song_5', to: "songs#get_song_recommendations"

      resources :follows
      get '/friends/:id', to: "follows#friends"

      resources :playlist_songs

    end
  end

end

