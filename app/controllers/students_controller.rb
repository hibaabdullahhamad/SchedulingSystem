class StudentsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        student = Student.new(student_params)
        if student.save
          render json: { message: 'Student created successfully', student: student }, status: :created
        else
          render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def search_tutors
        subject = params[:subject]
        day = params[:day]
        start_time = params[:start_time]
        end_time = params[:end_time]
        student_time_zone = params[:time_zone]
      
        # Extract availabilities with chosen subject
        tutors = Tutor.joins(:availabilities)
                      .where(subject: subject)
                      .where('availabilities.day = ?', day)
                      .where('availabilities.start_time <= ?', start_time)
                      .where('availabilities.end_time >= ?', end_time)
      
        if tutors.any?
          # Convert tutor availability to the student's time zone
          tutors_with_converted_availability = tutors.map do |tutor|
            tutor.as_json(include: {
              availabilities: {
                only: [:day, :start_time, :end_time],
                methods: :converted_availability_to_student_time_zone
              }
            })
        end
        
        render json: tutors_with_converted_availability
        else
          render json: { message: 'No tutors available for the given criteria' }, status: :not_found
        end
    end
      

    private

    def student_params
        params.require(:student).permit(:first_name, :last_name, :time_zone)
    end
end
