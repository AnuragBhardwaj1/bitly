# Links CRUD and redirection
class LinksController < ApplicationController
  before_action :find_link, :build_link, only: :create
  before_action :find_link_by_short_link, only: :redirect

  def index
    @links = Link.all
  end

  def create
    @link.save
    render 'home/index'
  end

  def show; end

  def redirect
    redirect_to @link.redirection_url if @link
  end

  private

  def build_link
    @link = Link.new(build_link_parms)
  end

  def build_link_parms
    params.require(:link).permit(:long_link)
  end

  def find_link
    @link = Link.find_by(long_link: params[:link][:long_link])
    render 'home/index' if @link
  end

  def find_link_by_short_link
    @link = Link.find_by(short_link: params[:short_link])
    redirect_to root_path, alert: 'Link not found' unless @link
  end
end
