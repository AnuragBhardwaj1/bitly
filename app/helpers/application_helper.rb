#applicaiton helper
module ApplicationHelper
  def flash_class(type)
    case type
      when "notice"
        "success"
      when "alert"
        "danger"
      when "error"
        "danger"
      else
        "info"
     end
  end
end
