# Gerar o projeto #

- $ rails new upload -d postgresql

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

# Depois sobrescreva o código do arquivo que contém o formulário para criação de uma nova publicação (app/views/posts/_form.html.erb):#

<div class="file">
  <label class="file-label">
    <%= form.file_field :avatar, direct_upload: true %>  
  </label>
</div>


# Sobrescreva o código de exibição de uma Publicação (app/views/posts/show.html.erb): #
- <%= image_tag @post.avatar %>
  
  # Por fim, adicione o componente card dentro da coluna criada anteriormente para exibir uma prévia da publicação, em (app/views/posts/index.html.erb): #
  #Entrega de imagem, Use o método cl_image_tag para gerar uma tag de imagem HTML ou use o método cloudinary_url para gerar uma URL de transformação.#
  

        <div class="card-image">
          <figure class="image is-full is-marginless is-3by1">
            <%= cl_image_tag(post.avatar.key) %>   
          </figure>
        </div>

# Active Storage configuração:
# Declare o serviço Cloudinary no arquivo config/storage.yml adicionando uma nova entrada com um nome personalizado (por exemplo, cloudinary) e a configuração do serviço: #

- cloudinary:      
  service: Cloudinary
  
  # Por exemplo, para usar o serviço cloudinary no ambiente de desenvolvimento, adicione o seguinte a config/environments/development.rb:#
  
  # Use Cloudinary.
config.active_storage.service = :cloudinary

# Carregamentos diretos
O Active Storage já oferece suporte ao upload direto do cliente para a nuvem. Depois de adicionar o Cloudinary como um serviço, use o upload direto como de costume: Inclua activestorage.js no pacote JavaScript do seu aplicativo.
Usando o pipeline de ativos:# em app/javascript/packs/application.js:#

- require("@rails/activestorage").start()

# instale o add-on no Heroku #

$ heroku addons:create cloudinary

# Por fim, adicione suas credenciais do Cloudinary, em Config Vars no Heroku: atenção os vars tem de estar nesse formato:
- API_KEY:*************,
-  API_SECRET:***********, 
-  Cloud_Name:***********

#Pronto seu app, está pronto p realizar upload de imagens no seu app.#




