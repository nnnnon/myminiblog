# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
   before_filter :configure_charsets

  
   helper :all # include all helpers, all the time
   include AuthenticatedSystem
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '307b8a34c931d02b46ef87ce7449305c'
  def configure_charsets
     response.headers["Content-Type"] = "text/html; charset=utf-8"
  end 
end
