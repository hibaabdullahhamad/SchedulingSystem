class AvailabilitiesController < ApplicationController

    def create
        availability = Availability.new(availability_params)
        if availability.save
            render json: { message: 'Availability added successfully' }, status: :created
        else
            render json: { errors: availability.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def index
        tutor = Tutor.find(params[:tutor_id])
        render json: tutor.availabilities
    end

    private

    def availability_params
        params.require(:availability).permit(:tutor_id, :day, :start_time, :end_time)
    end

end
