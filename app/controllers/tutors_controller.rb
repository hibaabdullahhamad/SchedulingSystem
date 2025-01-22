class TutorsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        tutor = Tutor.new(tutor_params)
        if tutor.save
          render json: { message: 'Tutor created successfully', tutor: tutor }, status: :created
        else
          render json: { errors: tutor.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def tutor_params
        params.require(:tutor).permit(:first_name, :last_name, :subject, :time_zone)
    end
end
