class UrlsController < ApplicationController
  before_action :set_url, only: %i[ show edit update destroy ]

  # GET /urls or /urls.json
  def index
    @urls = Url.all
  end

  # GET /urls/1 or /urls/1.json
  def show
  end

  # GET /urls/new
  def new
    @url = Url.new
  end


  # POST /urls or /urls.json
  def create
    @url = Url.new(url_params)
    @url.random_id = SecureRandom.uuid[0..5]

    # TODO: validate if random_id duplicated

    respond_to do |format|
      if @url.save
        format.html { redirect_to urls_path, notice: "Url was successfully created." }
        format.json { render :show, status: :created, location: @url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def random
    @url = Url.find_by(random_id: params[:id])
    redirect_to @url.original if @url
  end


  # DELETE /urls/1 or /urls/1.json
  def destroy
    @url.destroy

    respond_to do |format|
      format.html { redirect_to urls_url, notice: "Url was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def url_params
      params.require(:url).permit(:original, :random_id)
    end
end
