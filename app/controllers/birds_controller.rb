class BirdsController < ApplicationController

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    #bird = Bird.find_by(id: params[:id])
    bird = find_bird
    render json: bird
    rescue ActiveRecord::RecordNotFound
      #render json: { error: "Bird not found" }, status: :not_found
      render_not_found_response

  end

  #PATCH /birds/:id
  def update
    #bird = Bird.find_by(id: params[:id])
    bird = find_bird
    bird.update(bird_params)
    render json: bird
    
    rescue ActiveRecord::RecordNotFound
    #render json: { error: "Bird not found" }, status: :not_found
      render_not_found_response
  end

  # PATCH /birds/:id/like
  def increment_likes
    #bird = Bird.find_by(id: params[:id])
    bird = find_bird

    if bird
      bird.update(likes: bird.likes + 1)
      render json: bird
    else
      #render json: { error: "Bird not found" }, status: :not_found
      render_not_found_response
    end
  end

  # DELETE /birds/:id
  def destroy
    #bird = Bird.find_by(id: params[:id])
    bird = find_bird
    if bird
      bird.destroy
      head :no_content
    else
      #render json: { error: "Bird not found" }, status: :not_found
      render_not_found_response
    end
  end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

  #private helper method for generating the :not_found response
  def render_not_found_response
    render json: {error: "Bird not found"}, status: :not_found 
  end

  #private helper method to find a bird based on the ID in the params hash
  def find_bird
     #Bird.find_by(id: params[:id]) -> returns 'nil' if record isnt found
     Bird.find(params[:id])
     #we will get an ActiveRecord::RecordNotFound exception instead of nil 
     #when the record doesn't exist. 
  end

end
