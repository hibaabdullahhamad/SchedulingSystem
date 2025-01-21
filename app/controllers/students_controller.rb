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

    private

    def student_params
        params.require(:student).permit(:first_name, :last_name, :time_zone)
    end
end
