class EventsController < ApplicationController
	def index
		@user = User.find(session[:id])
		@eventsinstate = Event.where("state = ?", @user.state).limit(5)
		@eventsoutstate = Event.where("state != ?", @user.state).limit(3)
	end
	def show
		@event = Event.find(params[:id])
	end
	def create
		event = Event.new(event_params)
		unless event.save
			flash[:errors] = event.errors.full_messages
		end
		redirect_to '/events'
	end
	def destroy
		Event.find(params[:id]).destroy
		redirect_to '/events'
	end
	def attend
		Attendance.create(user: User.find(session[:id]), event: Event.find(params[:id]))
		redirect_to '/events'
	end
	def cancel
		Attendance.find_by(user: User.find(session[:id]), event: Event.find(params[:id])).destroy
		redirect_to '/events'
	end
	def comment
		comment = Comment.new(user:User.find(session[:id]), event: Event.find(params[:id]), content: params[:comment])
		if comment.save
			redirect_to "/events/#{params[:id]}"
		else
			flash[:errors] = comment.errors.full_messages
			redirect_to "/events/#{params[:id]}"
		end
	end
	private
	def event_params
		user = User.find(session[:id])
		params.require(:event).permit(:name, :date, :city, :state).merge(:host=>user)
	end
end