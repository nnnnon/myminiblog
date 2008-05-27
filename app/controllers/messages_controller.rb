require 'net/http'
require 'uri'

class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  #before_filter :authenticate
  before_filter :login_required
  #def authenticate
    #authenticate_or_request_with_http_basic do |name, pass|
      #User.authenticate(name, pass)
      #name == 'nnnnon' && pass == '2akgyv2a'      
    #end
  #end
  def index
     @message = Message.new
    #@messages = Message.paginate :page => params[:page],
                                 #:per_page => 5
        @pager = Paginator.new(Message.count, 10) do |offset, per_page|
            Message.find(:all, :order => "created_at DESC", :limit => per_page, :offset => offset)
          end
        @page = @pager.page(params[:page])
    # respond_to here if you want it                     
     MyMailer.create_send #建一个email对象
     MyMailer.deliver_send #发送email  

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end
  
    def add_message
      @message = Message.new(params[:message]) 
      @message.name = current_user.login
      @message.save
      update_twitter(@message.body,'nnnnon@gmail.com','2Akgyv2a')
      @pager = ::Paginator.new(Message.count, 10) do |offset, per_page|
            Message.find(:all, :order => "created_at DESC", :limit => per_page, :offset => offset)
          end
      @page = @pager.page(params[:page])
        respond_to do |format|      
        format.js
        end
    end

  # GET /messages/1/edit
  
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    update_twitter(@message.body,'nnnnon@gmail.com','2Akgyv2a')
    respond_to do |format|
      if @message.save
        #flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(messages_url) }
        #format.html { render :action => "index" }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(@message) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
   def update_twitter(update_text,twitter_email,twitter_password)

    begin
      url = URI.parse('http://twitter.com/statuses/update.xml')
      req = Net::HTTP::Post.new(url.path)
      req.basic_auth twitter_email,twitter_password
      req.set_form_data({'status' => update_text})

      begin
        res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }

        case res
        when Net::HTTPSuccess, Net::HTTPRedirection
          if res.body.empty?
             flash[:notice] = 'twitter'
          else
             flash[:notice] = 'Message was successfully updated.'
          end

        else
          flash[:notice] = 'Message was successfully updated.'
          res.error!
        end

      rescue
        flash[:notice] = 'Message was successfully updated.'
      end

    rescue SocketError
      flash[:notice] = 'Message was successfully updated.'
    end
  end
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
end
