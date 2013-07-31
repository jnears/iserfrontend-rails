Rails.application.routes.draw do

  get '/styleguide' => 'styleguides#index', :as => :styleguide

end
