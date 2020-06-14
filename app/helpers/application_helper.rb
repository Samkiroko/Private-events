module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Private Events App'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

   def show_header_if_user_logged_in
    render 'header' if logged_in?
   end

  def print_errors_if_any(object)
    render 'error_messages' if object.errors.any?
  end


end

