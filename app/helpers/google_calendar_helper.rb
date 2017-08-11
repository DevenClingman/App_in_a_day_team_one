require 'googleauth'
require 'google/apis/calendar_v3'

module GoogleCalendarHelper
	
  attr_reader :calendar
  SCOPE = ["https://www.googleapis.com/auth/calendar"]
  CALENDAR_ID = '3qonl2mhums56pqd588s3mqjv4@group.calendar.google.com'
	
  def initializea
	@calendar = Google::Apis::CalendarV3::CalendarService.new
	# get_application_default forces the use of this environment variable.
	# Set it to the location of your JSON credentials.
	ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "./DevcampTAScheduler-f1b651e8766a.json"
	@calendar.authorization = Google::Auth.get_application_default(SCOPE)
  end
end