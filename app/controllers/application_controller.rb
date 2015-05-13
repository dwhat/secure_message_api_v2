class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  helper_method :checkTimestamp

  def checkTimestamp(recipient_timestamp)
    server_timestamp = Time.now.to_i
    server_timestamp_late = server_timestamp + 300
    server_timestamp_early = server_timestamp - 300

    if (server_timestamp_early .. server_timestamp_late).include?(recipient_timestamp)
      return true
    else
      return false
    end
  end

end
