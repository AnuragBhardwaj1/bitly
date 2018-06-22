# Links CRUD and redirection
class LinksController < ApplicationController
  before_action :find_link, :build_link, only: :create
  before_action :find_link_by_short_link, only: :redirect

  def index
    @links = Link.all
  end

  def create
    if @link.save
      flash.now[:notice] = I18n.t(:created, scope: [:link, :success])
    else
      flash.now[:error] = @link.errors.full_messages.to_sentence
    end
    render 'home/index'
  end

  def show; end

  def redirect
    redirect_to @link.redirection_url if @link
  end

  private

  def build_link
    @link = Link.new(link_parms)
  end

  def link_parms
    params.require(:link).permit(:long_link)
  end

  def find_link
    @link = Link.find_by(long_link: link_parms[:long_link])
    if @link
      flash.now[:notice] = I18n.t(:exist, scope: [:link, :success])
      render 'home/index'
    end
  end

  def find_link_by_short_link
    @link = Link.find_by(short_link: params[:short_link])
    redirect_to root_path, alert: I18n.t(:invalid, scope: [:link, :error]) unless @link
  end
end
