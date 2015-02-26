class EventsController < ApplicationController
  respond_to :html, :json
  before_filter :set_headers
  skip_before_action :verify_authenticity_token
  def index
    @user = current_user
    @events = []
    app_names = []
    Event.all.each do |event|  
      @events << event unless app_names.include?(event.app_name)
      app_names << event.app_name
      
    end
    @events
  end

  def show
    @events = Event.all
    @event = Event.find(params[:id])
    @app_name = @event.app_name
  end

  def new
    @event = Event.new
  end
  
  def destroy
    @event = Event.find(params[:id])
    Event.where(app_name: @event.app_name).delete_all
    if @event.destroy
      flash[:notice] = "Your App was Deleted"
      redirect_to events_path
    else
      flash[:error] = "There was an error"
      redirect_to events_path
    end
  end

  def create
    @event = Event.new(events_params)
    @email = events_params["email"]
    @app_name = events_params["app_name"]
    @event.email = @email
    @event.app_name = @app_name
    @event.ip_address = request.env["HTTP_X_FORWARDED_FOR"]
    @user = User.find_by_email(@email)
    if @user # if user exists
      @event.user_id = @user.id
      @event.save
      redirect_to events_path
    else 
      @user = User.new(email: @email, password:"password", password_confirmation:"password")
      @user.skip_confirmation!
        @user.save
      @event.user_id = @user
      @event.save
      redirect_to events_path
    end
#     if @event.save
#       flash[:notice] = "Event Saved"
#       respond_to do |format|
#         format.json { head :ok}
#         format.html { redirect_to events_path }
#       end     
#     else
#       flash[:error] = "There was an error"
#       respond_to do |format|
        #format.json { status: "error" }
#         format.html { render :new }
#       end     
#     end
  end
  def events_params
    params.require(:event).permit(:app_name, :event_type, :user_id, :email)
  end

  def edit
    @event = Event.find(params[:id])
  end
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(events_params)
      flash[:notice] = "Event Updated"
      redirect_to events_path
    else
      flash[:error] = "There was an error"
      render :edit
    end
  end
  def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Expose-Headers'] = 'ETag'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
      headers['Access-Control-Max-Age'] = '1728000'
    end
end
