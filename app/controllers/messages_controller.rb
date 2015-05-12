class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    server_timestamp = Time.now.to_i
    server_timestamp_late = server_timestamp + 300
    server_timestamp_early = server_timestamp - 300

    recipient_timestamp = request.headers['HTTP_TIMESTAMP'].to_i
    sig_user = request.headers['HTTP_sig_user']

    # Zeit Check
    if (server_timestamp_early .. server_timestamp_late).include?(recipient_timestamp)
      # Signatur Check
      digest = OpenSSL::Digest::SHA256.new
      #if key.verify digest, signature, document
        @messages = Message.where(:recipient => params[:user_id])
      else
        #Fehlermeldung Inkorrekte Signatur
      end
    else
       #Fehlermeldung Time passt nicht
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)


    respond_to do |format|
      if @message.save
        format.html { redirect_to [:user,@message], notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: [:user,@message] }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:sender, :cipher, :iv, :key_recipient_enc, :sig_recipient, :timestamp, :recipient, :sig_service)
    end
end
