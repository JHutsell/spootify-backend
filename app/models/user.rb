class User < ApplicationRecord
    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :following_users
    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followees, through: :followed_users
    
    has_many :playlists
    #has_many :songs, through: playlists


    def access_token_expired?
        #return true if access_token is older than 55 minutes, based on update_at
        (Time.now - self.updated_at) > 3300
    end
    
    def refresh_access_token
        # Check if user's access token has expired
        if access_token_expired?
            #Request a new access token using refresh token
            body = {
            grant_type: "refresh_token",
            refresh_token: self.refresh_token,
            client_id: ENV['CLIENT_ID'],
            client_secret: ENV["CLIENT_SECRET"]
            }
            auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
            auth_params = JSON.parse(auth_response)
            self.update(access_token: auth_params["access_token"])
        else
            puts "Current user's access token has not expired"
        end
    end

end
