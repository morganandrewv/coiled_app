class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@order = current_user.orders.build
  end

  def new
		@user = User.new
  end

  def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "User created successfully. Welcome!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
	end

	def update
    if @user.update_attributes(user_params)
      sign_in @user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to root_path
  end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end
