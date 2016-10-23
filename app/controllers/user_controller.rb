class UserController < ApplicationController
  respond_to :json

  def setServices
    user = User.find(params[:user][:id])
    binding.pry
    user.services = []
    for serv in params[:user][:services]
       user.services.push(serv)
    end
    user.save
    render :json => {:user => user}
  end

private
  def user_params
    params.require(:user).permit(:id, :services => [])
  end
end
