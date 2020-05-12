class ArticlesController < ApplicationController
before_action :set_article, only: [:edit, :update, :show, :destroy]
before_action :require_user, except: [:index, :show]
before_action :require_save_user, only: [:edit, :updated, :destroy]

	def new
    @article = Article.new
  end

  def edit
  end

	def index
		@articles = Article.paginate(:page => params[:page], :per_page => 5)
	end

  def create
    @article = Article.new(article_params)
		@article.user = current_user
    if @article.save
      flash[:success] = "artcile bien créé"
  	   redirect_to article_path(@article)
    else
  	   render "new"
    end

  end

def update
    if @article.update(article_params)
      flash[:success] = "artcile bien modifié"
  	  redirect_to articles_path(@article)
    else
  	  render "edit"
    end
end

  def show
  end

	def destroy
     @article.destroy
		 flash[:danger] = "Article supprimé"
     redirect_to articles_path
	 end

  private

	def set_article
      @article = Article.find(params[:id])
	end

  def article_params
  	params.require(:article).permit(:title, :description)
  end

	def require_save_user
		if current_user != @article.user and current_user.admin? == false
			flash[:danger] = 	"Hé ho hé ho hé ho la !! Frero tu peut pas faire ca, c'est pas ton article ! Nan mais dit donc "
			redirect_to root_path
		end
	end

end
