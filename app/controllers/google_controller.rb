class GoogleController < ApplicationController
    def redirect
      client = Signet::OAuth2::Client.new({
        client_id: ENV.fetch("GOOGLE_CLIENT_ID"),
        client_secret: ENV.fetch("GOOGLE_CLIENT_SECRET"),
        authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        redirect_uri: callback_url
      })
  
      redirect_to client.authorization_uri.to_s
    end
  
    def callback
        client = Signet::OAuth2::Client.new({
          client_id: ENV.fetch("GOOGLE_CLIENT_ID"),
          client_secret: ENV.fetch("GOOGLE_CLIENT_SECRET"),
          token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
          redirect_uri: callback_url,
          code: params[:code]
        })
    
        response = client.fetch_access_token!
    
        session[:authorization] = response
    
        redirect_to calendars_url
      end

      def calendars
        client = Signet::OAuth2::Client.new({
          client_id: ENV.fetch("GOOGLE_CLIENT_ID"),
          client_secret: ENV.fetch("GOOGLE_CLIENT_SECRET"),
          token_credential_uri: 'https://accounts.google.com/o/oauth2/token'
        })
    
        client.update!(session[:authorization])
    
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
    
        @calendar_list = service.list_calendar_lists
      end

      def events
        client = Signet::OAuth2::Client.new({
          client_id: ENV.fetch("GOOGLE_CLIENT_ID"),
          client_secret: ENV.fetch("GOOGLE_CLIENT_SECRET"),
          token_credential_uri: 'https://accounts.google.com/o/oauth2/token'
        })
    
        client.update!(session[:authorization])
    
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
    
        @event_list = service.list_events(params[:calendar_id])
      end
end

