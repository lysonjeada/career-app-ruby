require 'sinatra'
require 'sequel'
require_relative './db_setup'

# Modelo
class User < Sequel::Model(:users)
end

# Rota para listar todos os usuários
get '/users' do
  users = User.all.map { |user| { id: user.id, name: user.name, email: user.email } }
  users.to_json
end

# Rota para criar um novo usuário
post '/users' do
  payload = JSON.parse(request.body.read)
  user = User.create(name: payload['name'], email: payload['email'])
  user.to_json
end

# Rota para mostrar um usuário específico
get '/users/:id' do
  user = User[params['id']]
  halt(404, { error: 'User not found' }.to_json) unless user
  user.to_json
end

# Rota para atualizar um usuário
put '/users/:id' do
  payload = JSON.parse(request.body.read)
  user = User[params['id']]
  halt(404, { error: 'User not found' }.to_json) unless user
  user.update(name: payload['name'], email: payload['email'])
  user.to_json
end

# Rota para deletar um usuário
delete '/users/:id' do
  user = User[params['id']]
  halt(404, { error: 'User not found' }.to_json) unless user
  user.destroy
  { message: 'User deleted' }.to_json
end
