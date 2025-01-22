class BookingsController < ApplicationController

    skip_before_action :verify_authenticity_token


    def create
        booking = Booking.new(booking_params.merge(student_id: params[:student_id]))
        if booking.save
          render json: { message: 'Booking created successfully', booking: booking }, status: :created
        else
          render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    private
    
    def booking_params
        params.require(:booking).permit(:tutor_id, :day, :time_slot)
    end

end
