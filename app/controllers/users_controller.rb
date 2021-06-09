 
class UsersController < ApplicationController
    before_action :authorized, only: [:auto_log]
     

    def create

        @user =  User.create(params_user)

        
        if @user.valid?
            @user.save
            
            WelcomeMailer.signup_welcome(@user).deliver

            payload = {user_id: @user.id}
            token = JWT.encode payload,"secret",'HS256'
            render json: {user:@user, token: token},message: "hola", status: :created
        else
            render json: {error: "El usuario no pudo ser registrado"}
        end

    end


    def login
         @user = User.find_by_email(params[:email])

         if @user && @user.authenticate(params[:password])
            payload = {user_id: @user.id}
            token = JWT.encode payload, "secret", "HS256"
            render json: {user:@user, token: token}, status: :created 
         else
            render json: {error: "Email y/o contraseña invalido"}
         end
    end

    def auto_log 
        render json: {message: "Hola"}
    end

    private 


    def params_user
        params.permit(:email, :password)
    end
end
