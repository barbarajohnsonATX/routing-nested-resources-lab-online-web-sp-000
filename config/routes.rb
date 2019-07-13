Rails.application.routes.draw do
  #resources :artists
  resources :artists, only: [:show] do
    # nested resource for songs
    resources :songs, only: [:show, :index]
  end
  resources :songs

end
