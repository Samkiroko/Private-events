module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user
  end

  def render_links
    if signed?
      render partial: 'layouts/links_signed'
    else
      render partial: 'layouts/links_not_signed'
    end
  end
end
