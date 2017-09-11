Rails.application.routes.draw do
  resources :pixels
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: "users/registrations"}
  get 'pagamento/index'
  #match '*path' => redirect('/'), via: :get
  match ':not_found' => redirect('/'), via: :get

  #resources :seguros
  resources :orcamentos
  #get 'orcamentos/new'

	scope "orcamentos/:_id" do
	resources :steps
	end

  #resources :steps
  root 'orcamentos#new'
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
