class UsersController < ApplicationController
	def index

	end
	def new
		user = User.new(user_params)
		if user.save
			session[:id] = user.id
			redirect_to '/events'
		else
			flash[:errors]=user.errors.full_messages
			redirect_to '/'
		end

	end
	def login
		user = User.find_by(email:params[:email])
		if user && user.authenticate(params[:password])
			session[:id] = user.id
			redirect_to '/events'
		elsif user
			flash[:logerror] = "Your password does not match our records"
			redirect_to '/'
		else
			flash[:logerror] = "Your email does not match any of our records"
			redirect_to '/'
		end 
	end
	def edit
		@user = User.find(session[:id])
	end
	def update
		user = User.update(session[:id],user_params)
		if user.save
			redirect_to '/events'
		else 
			flash[:errors]=user.errors.full_messages
			redirect_to "/users/#{session[:id]}"
		end
	end
	def logout
		session[:id] = nil
		redirect_to '/'
	end

	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
	end

end
