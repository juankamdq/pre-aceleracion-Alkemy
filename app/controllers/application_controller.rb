class ApplicationController < ActionController::API


    # Decodificar el Token

    def decode_token

        
        if request.headers['Authorization']
            encoded_token = request.headers['Authorization'].split(' ')[1]

            token = JWT.decode(encoded_token, 'secret', true, algorithm: 'HS256')
            user_id = token[0]['user_id']
            user = User.find_by_id(user_id)
        end
    end


    # Verifico si esta o no autorizado. Sera utilizado para dar con acceso a las acciones
    def authorized
        if !decode_token
            render json: {message: "Please Sign In"}, status: :unauthorized
        end
    end

end
