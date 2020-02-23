class PetsController < ApplicationController

  set :method_override, true

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets' do 
   
    pet = Pet.create(name: params[:pet_name])
    if params[:owner]
      pet.update(owner_id: params[:owner])
    end
    if params[:owner_name] != ""
      owner = Owner.create(name: params[:owner_name])
      pet.update(owner_id: owner.id)
    end
    redirect to "pets/#{pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch'/pets/:id' do 
    pet = Pet.find(params[:id])
    pet.update(name: params[:pet_name])
    if params[:owner][:id]
      pet.update(owner_id: params[:owner][:id])
    end
    if params[:owner][:name] != ""
      owner = Owner.create(name: params[:owner][:name])
      pet.update(owner_id: owner.id)
    end
    redirect to "pets/#{@pet.id}"
  end
end