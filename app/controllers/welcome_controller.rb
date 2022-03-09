class WelcomeController < ApplicationController
    def index
        response = DocumentValidator.call(params[:cpf])
        render json: response
    end
end
