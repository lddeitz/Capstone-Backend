class Api::SongsController < ApplicationController

  before_action :authenticate_user, except: [:show]
  # before_destroy :destroy_comment

  def create
    @song = Song.new(
      user_id: current_user.id,
      title: params[:title],
      description: params[:description],
      keywords: params[:keywords],
      url: params[:url],
      img_url: params[:img_url]
    )
    if @song.save
      render json: { message: "Song created successfully" }, status: :created
    else
      render json: { errors: @song.errors.full_messages }, status: :bad_request
    end 
  end 

  def show
    @song = Song.find(params[:id])
    render "show.json.jb"
  end 

  def update
 
    @song = Song.find(params[:id])
    
    if @song.user_id == current_user.id
      @song.title = params[:title] || @song.title
      @song.description = params[:description] || @song.description
      @song.keywords = params[:keywords] || @song.keywords
      @song.url = params[:url] || @song.url
      @song.img_url = params[:img_url] || @song.img_url
        
      if @song.save
        render "show.json.jb"
      else 
        render json: { errors: @song.errors.full_messages }, status: :bad_request
      end 
    end 

  end 

  def destroy
 
    @song = Song.find(params[:id])

    if @song.user_id == current_user.id
      if @song.destroy
        render json: { message: "Song successfully destroyed" }
      else 
        render json: { errors: @song.errors.full_messages }, status: :bad_request
      end
    end 

  end 

end