class BookingsController < ApplicationController

    skip_before_action :verify_authenticity_token


    def create
        booking = Booking.new(booking_params)
        if booking.save
          render json: { message: 'Booking created successfully' }, status: :created
        else
          render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
    def index
        student = Student.find(params[:student_id])
        render json: student.bookings
    end
    
    private
    
    def booking_params
        params.require(:booking).permit(:student_id, :tutor_id, :day, :time_slot)
    end

end
