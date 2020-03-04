class PeopleController < ApplicationController
  require 'json'

  before_filter :set_object, only: [:show, :edit, :update, :destroy]
  
  # GET /people
  def index
    
    # INCLUDES for people 
    # possible options: positions, companies, tags, tasks, avatar, tels, 
    # emails, ims, sms, homepages, addrs, custom_fields
    
    # includes = if params[:includes] == 'selected'
    #   'emails addrs addrs.zip addrs.plz' 
    # elsif params[:includes] == 'all'
    #   'all'
    # elsif params[:includes] == 'name'
    #   'user_id'
    # else
    #   ''
    # end
    
    #options = { order: params[:order], includes: includes }
    options = { includes: 'emails addrs addrs.zip addrs.plz'  }

    begin
    @people = Person.find(:all,
      params: {includes: 'emails addrs'}
      #params: {includes: 'emails addrs'}
      #params: {includes: [:emails, :addrs]}
      )

      respond_to do |format|
        format.html
      end
    rescue ActiveResource::UnauthorizedAccess => e
      render :text => "unauthorized, please check your crm SITE and APIKEY in conf/environments/#{Rails.env}"
    end
  end

  def search
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  # GET /people/search
  def search_result
    @people = Person.search params[:name], params[:first_name], params[:per_page] ? params[:per_page] : 10


    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /people/1
  def show    
    
    respond_to do |format|
      format.html # show.html.erb
      format.json # show.html.erb
    end
  end

  # GET /people/new
  def new
    @person = Person.remote_new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  def create


    @person = Person.new(person_params)
    
    respond_to do |format|
      if @person.save
        format.html { redirect_to(person_path(@person), :notice => 'Person was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /people/1
  def update
  
    respond_to do |format|
      if @person.update(person_params).save
        format.html { redirect_to(person_path(@person), :notice => 'Person was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
    end
  end
  
  
  protected
  
  def set_object    
    @person = Person.find(params[:id], params: {includes: 'companies addrs tags tasks emails'})
  rescue ActiveResource::UnauthorizedAccess => e
    render :text => "unauthorized, please check your SITE and APIKEY in conf/environments/#{Rails.env}"
  end
  
  def person_params
    params.require(:person).permit(Person::PERMITTED_PARAMS, :addrs_attributes => [:plz, :zip])
  end
  
end
