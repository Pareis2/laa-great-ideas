class IdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :submit]
  
  # GET /ideas
  # GET /ideas.json
  def index
    if params[:view]
      view = params[:view]
      if view.eql?("assigned")
        @ideas = Idea.where(assigned_user_id: [current_user.id])
      elsif view.eql?("submitted")
        @ideas = Idea.where.not(submission_date: [nil, ""]).where(assigned_user_id: [nil, ""])
      elsif view.eql?("user")
        @ideas = current_user.ideas.all
      end
    else
      @ideas = Idea.all
    end  
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = current_user.ideas.new(idea_params)

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def submit
    @idea.submission_date = Time.now
    if @idea.save
      redirect_to @idea, notice: 'Idea was successfully submitted.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id]||params[:idea_id]) 
    end

   # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      if current_user.admin?
        params.require(:idea).permit(:area_of_interest, :business_area, :it_system, :title, :idea, :benefits, :impact, :involvement, :assigned_user_id)
      else
        params.require(:idea).permit(:area_of_interest, :business_area, :it_system, :title, :idea, :benefits, :impact, :involvement)    
      end
    end
end
