class AttemptsController < ApplicationController
  before_filter :require_user
  
  autocomplete :campaign, :title, :full => true
  autocomplete :company, :title, :full => true
  
  # GET /attempts
  # GET /attempts.xml
  def index
    @attempts = Attempt.page(params[:page])
    @title = "Contact Attempts"
  end

  # GET /attempts/1
  # GET /attempts/1.xml
  def show
    @attempt = Attempt.find(params[:id])
    @title = "Attempt ##{@attempt.id}"
  end

  # GET /attempts/new
  # GET /attempts/new.xml
  def new
    @attempt = Attempt.new
    @attempt.campaign_id = 1
    @attempt.user = current_user
    @title = "New Contact Attempt"
  end

  # GET /attempts/1/edit
  def edit
    @attempt = Attempt.find(params[:id])
    @title = "Editing Attempt"
  end

  # POST /attempts
  # POST /attempts.xml
  def create
    @attempt = Attempt.new(params[:attempt])

    if @attempt.save
      redirect_to(attempts_path, :flash => { :success => 'Contact Attempt successfully created' })
    else
      @title = "New Contact Attempt"
      render :action => "new"
    end
  end

  # PUT /attempts/1
  # PUT /attempts/1.xml
  def update
    @attempt = Attempt.find(params[:id])

    if @attempt.update_attributes(params[:attempt])
      redirect_to(@attempt, :flash => { :success => 'Contact Attempt successfully updated' })
    else
      @title = "Editing Attempt"
      render :action => "edit"
    end
  end

  # DELETE /attempts/1
  # DELETE /attempts/1.xml
  def destroy
    @attempt = Attempt.find(params[:id])
    @attempt.destroy

    redirect_to(attempts_url)
  end
end
