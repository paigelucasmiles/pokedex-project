class AuthenticationController < ApplicationController
    
    # skip_before_action :verify_auth, only: [:login]

    def login
        @user = User.find_by username: params[:username]

        if (@user&.authenticate(params[:password]))
            @token = JWT.encode({
                user_id: @user.id
            }, Rails.application.secrets.secret_key_base)

            render json: {token: @token}, status: :ok
        else 
            render json: {message: 'Invalid login credentials'}, status: :unauthorized
        end
    end

end
