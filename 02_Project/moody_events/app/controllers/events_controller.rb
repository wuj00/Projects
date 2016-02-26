class EventsController < ApplicationController

# before_action :authorize, only: [:index, :show]

  def index
    @events = Event.all
    @events = Event.search(params[:search])
     if params[:search]
      @events = Event.search(params[:search]).order("created_at DESC")
    else
      @events = Event.order("created_at DESC")
    end
  end

  def show
    @event = Event.find(params[:id])
    # @user = User.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    if @event = current_user.events.new(event_params)
        @event.save
      redirect_to events_path
    else
      redirect_to events_new_path
    end
  end

  def edit
    @event = Event.find(params[:id])
    # if current_user.id == @event.user.id
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to user_path @event
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
      redirect_to user_path @event
  end

private
  def event_params
    params.require(:event).permit(:name, :url)
  end
end
