class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end

  def index
    @user = current_user
    @bookings = @user.bookings
  end

  def create
    @user = current_user
    @dog = Dog.find(params[:dog_id])
    @booking = Booking.new(booking_params)
    @booking.dog = @dog
    @booking.user = @user
    @booking.save
    if @booking.id
      redirect_to dogs_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def new
    @booking = Booking.new(booking_params)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :dog_id, :user_id, :status)
  end
end
