class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    recipient_timestamp = params[:timestamp].to_i
    puts params[:sig_user]
    document = params[:user_id].to_s+recipient_timestamp.to_s
    sig_user = Base64.strict_decode64(params[:sig_user])
    puts "============================================"
    puts sig_user
    puts "============================================"
    puts document
    puts "============================================"

    if checkTimestamp(recipient_timestamp)
      # Signatur Check
      digest = OpenSSL::Digest::SHA256.new
      @user = User.find_by_name(params[:user_id])
      key = OpenSSL::PKey::RSA.new(Base64.strict_decode64(@user.pubkey_user))
      if key.verify digest, sig_user, document
        puts "============================================"
        puts "Signature valid"
        puts "============================================"
        @messages = Message.where(:recipient => params[:user_id])
        Message.where(:recipient => params[:user_id]).destroy_all
      else
        #Fehlermeldung Inkorrekte Signatur
        puts "============================================"
        puts "Signature invalid"
        puts "============================================"
        render json: @status = '{"status":"503"}'
      end
    else
      # Timestamp passt nicht
      puts "============================================"
      puts "Timestamp invalid"
      puts "============================================"
      render json: @status = '{"status":"502"}'
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

      if checkTimestamp(@message.timestamp.to_i)
          if @message.save
            puts "============================================"
            puts "Message created"
            puts "============================================"
            format.html { redirect_to @message, notice: 'Message was successfully created.' }
            format.json { render json: @status = '{"status":"200"}'}
          else
            format.html { render :new }
            format.json { render json: @status = '{"status":"500"}' }
          end

      else
        format.json { render json: @status = '{"status":"502"}'}
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
    puts "============================================"
    puts "Message deleted"
    puts "============================================"
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { render json: @status = '{"status":"200"}'}
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
