# Gerar o projeto #

- $ rails generate upload -d postgresql

# Gerar o banco de dados #

- $ rails db:create

# Gerar um scaffold #

- $ rails g scaffold Post title author --no-stylesheets

# Rodar a migração #

- $ rails db:migrate

# Torne a Listagem de Publicações a página inicial da sua aplicação, em (config/routes.rb) coloque:

- root to: 'posts#index'

# Instalar o Active Storage #

- $ rails active_storage:install

# Rodar uma nova migração #

- $ rails db:migrate

# Adicione a Imagem de Destaque ao Model Post, em (app/models/post.rb) coloque:

- class Post < ApplicationRecord
- has_one_attached :avatar
- end

# Atualize a permissão de parâmetros para conseguir salvar o que foi adicionado (app/controllers/posts_controller.rb): #

- def post_params
-  params.require(:post).permit(:title, :author, :avatar)
- end

# Ajustando as Views
#Agora você irá alterar o conteúdo das views para melhorar a visualização de suas páginas.
Substitua o conteúdo de new.html.erb (app/views/posts/new.html.erb):#

- </br></br> <h1 class="title is-1">Nova Publicação</h1> 
 
- <%= render 'form', post: @post %>

# Depois sobrescreva o código do arquivo que contém o formulário para criação de uma nova publicação (app/views/posts/_form.html.erb):

- <%= form_with(model: post, local: true) do |form| %>
<% if post.errors.any? %>
<div id="error_explanation">
  <h2><%= pluralize(post.errors.count, "error") %> prohibited this post from being saved:</h2>

  <ul>
    <% post.errors.full_messages.each do |message| %>
    <li><%= message %></li>
    <% end %>
  </ul>
</div>
<% end %>

<div class="file">
  <label class="file-label">
    <%= form.file_field :avatar, direct_upload: true %>  ----- Atenção aqui, para selecionar a imagem na página de formulário. 
  </label>
</div>

</br>

<div class="field">
  <%= form.label 'Título', class: 'label' %>
  <div class="control">
    <%= form.text_field :title, class: 'input' %>
  </div>
</div>

<div class="field">
  <%= form.label 'Autor', class: 'label' %>
  <div class="control">
    <%= form.text_field :author, class: 'input' %>
  </div>
</div>

<div class="field">
  <%= form.label 'Conteúdo', class: 'label' %>
  <%= form.rich_text_area :content %>
</div>

<div class="field is-grouped">
  <div class="control">
    <%= form.submit 'Criar', class: 'button is-link' %>
  </div>
  <div class="control">
    <%= link_to 'Voltar', posts_path, class: 'button is-link is-light' %>
  </div>
</div>
<% end %>

# Sobrescreva o código de exibição de uma Publicação (app/views/posts/show.html.erb):

- </br></br>
<figure class="image is-3by1">
  <%= image_tag @post.avatar %>
</figure></br>
<div class="columns">
  <div class="column">
    <p class="title"><%= @post.title %></p>   ----- Muito importante, para poder exibir a imagem cadastrada na página show.
  </div>
</div></br></br>
<div class="columns">
  <div class="column is-three-quarters"><%= @post.content %>
  </div>
  
  # Por fim, adicione o componente card dentro da coluna criada anteriormente para exibir uma prévia da publicação, em (app/views/posts/index.html.erb): #
  #Entrega de imagem, Use o método cl_image_tag para gerar uma tag de imagem HTML ou use o método cloudinary_url para gerar uma URL de transformação.#
  
  - </br></br>
<h1 class="title">Publicações</h1>
</br>
 
<% @posts.each do |post| %>
  <div class="columns">
    <div class="column is-four-fifths">
 <div class="card">
        <div class="card-image">
          <figure class="image is-full is-marginless is-3by1">
            <%= cl_image_tag(post.avatar.key) %>   
          </figure>
        </div>
        <div class="card-content">
          <div class="media">
            <div class="media-content">
              <a href="<%= post_path(id: post.id) %>"><p class="title is-4"><%= post.author %></p></a>
            </div>
          </div>
          <p>Autor: <%= post.author %> - <%= post.created_at.strftime("%d/%m/%Y") %></p>
        </div>
      </div>
    </div>
  </div>
<% end %>

# Active Storage configuração:
# Declare o serviço Cloudinary no arquivo config/storage.yml adicionando uma nova entrada com um nome personalizado (por exemplo, cloudinary) e a configuração do serviço: #

- cloudinary:      
  service: Cloudinary
  
  # Por exemplo, para usar o serviço cloudinary no ambiente de desenvolvimento, adicione o seguinte a config/environments/development.rb:#
  
  # Use Cloudinary.
config.active_storage.service = :cloudinary

# Carregamentos diretos
O Active Storage já oferece suporte ao upload direto do cliente para a nuvem. Depois de adicionar o Cloudinary como um serviço, use o upload direto como de costume:

Inclua activestorage.js no pacote JavaScript do seu aplicativo.

Usando o pipeline de ativos:# 

- require("@rails/activestorage").start()

# instale o add-on no Heroku #

$ heroku addons:create cloudinary

# Por fim, adicione suas credenciais do Cloudinary, em Config Vars no Heroku: atenção os vars tem de estar nesse formato:
- API_KEY:*************, API_SECRET:***********, Cloud_Name:***********

#Pronto seu app, está pronto p realizar upload de imagens no seu app.#




