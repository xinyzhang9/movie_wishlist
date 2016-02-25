class UsersController < ApplicationController
  def index

  end

  def create
    @user = User.new(user_params)
    if !@user.save
      flash[:errors] = @user.errors.full_messages
      redirect_to :back

    else
      #save user, get top rated movies for users to pick
      @user.save
      $counter = 1
      session[:user_id] = @user.id
      render :set_up
    end
  end

  def show
  end

  def set_up
    ApisController.get_top_movie


  end

  def carts
    # puts data.inspect
    @movie_title = params[:movie_title]
    @movie_id = params[:movie_id]
    (session[:movie_list] ||= []) << (params[:movie_title] unless session[:movie_list].include?params[:movie_title])
    render :json => { 
         :movie_title => @movie_title, 
         :movie_id => @movie_id
      }
  end
  private
  def user_params
    params.require(:user).permit(:email,:first_name,:last_name,:password,:password_confirmation)
  end
end