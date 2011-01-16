Catarse::Application.routes.draw do
  
  # TODO change back the root to "projects#index" when we launch
  if Rails.env == "production"
    root :to => "projects#teaser"
  else
    root :to => "projects#index"
  end
  
  match "/guidelines" => "projects#guidelines", :as => :guidelines
  match "/faq" => "projects#faq", :as => :faq
  match "/terms" => "projects#terms", :as => :terms
  match "/privacy" => "projects#privacy", :as => :privacy
  match "/thank_you" => "projects#thank_you", :as => :thank_you
  
  post "/auth" => "sessions#auth", :as => :auth
  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"
  match "/logout" => "sessions#destroy", :as => :logout
  if Rails.env == "test"
    match "/fake_login" => "sessions#fake_create", :as => :fake_login
  end
  resources :projects, :only => [:index, :new, :create, :show] do
    collection do
      get 'teaser'
      get 'guidelines'
      get 'faq'
      get 'terms'
      get 'privacy'
      get 'vimeo'
      get 'pending'
      get 'pending_backers'
      get 'thank_you'
      post 'update_attribute_on_the_spot'
    end
    member do
      get 'back'
      post 'review'
      get 'backers'
      get 'embed'
      get 'video_embed'
    end
  end
  resources :users, :only => [:show] do
    post 'update_attribute_on_the_spot', :on => :collection
  end
end
