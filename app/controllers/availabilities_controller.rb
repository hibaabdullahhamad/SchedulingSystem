class AvailabilitiesController < ApplicationController

    skip_before_action :verify_authenticity_token

    def add_or_update
        availability = Availability.find_or_initialize_by(
          tutor_id: params[:tutor_id],
          day: params[:day]
        )
    
        availability.assign_attributes(
          start_time: params[:start_time],
          end_time: params[:end_time],
          time_zone: params[:time_zone]
        )
    
        if availability.save
          render json: { message: 'Availability added successfully' }, status: :created
        else
          render json: { errors: availability.errors.full_messages }, status: :unprocessable_entity
        end
    end
      

    def create
        Rails.logger.debug("Params received: #{params.inspect}")
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
