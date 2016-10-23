class InNeedController < ApplicationController
  respond_to :json

  #This is for mobile
  def inNeedMobile
    inNeed = InNeed.find_by(first_name: params[:inNeed][:first_name], last_name: params[:inNeed][:last_name], last4_ssn: params[:inNeed][:last4_ssn])

    if inNeed.nil?
      render :json => {:success => false }
    else
      # Get all the services they have. 
      services_to_return = []
      Service.where(in_need_id: inNeed.id).find_each do |service|
        services_to_return.push(service.as_json)
      end
      render :json => {:success => true, :services => services_to_return}
    end
  end

  def inNeedWeb
    inNeed = InNeed.find_by(first_name: params[:inNeed][:first_name], last_name: params[:inNeed][:last_name], last4_ssn: params[:inNeed][:last4_ssn])

    if inNeed.nil?
      inNeed = InNeed.new(inNeed_params)
      inNeed.save
      # Get all the services they have. 
      services_to_return = []
      Service.where(in_need_id: inNeed.id).find_each do |service|
        services_to_return.push(service.as_json)
      end
      render :json => {:services => services_to_return}
    else
      services_to_return = []
      Service.where(in_need_id: inNeed.id).find_each do |service|
        services_to_return.push(service.as_json)
      end
      render :json => {:services => services_to_return}
    end
  end

private
  def inNeed_params
    params.require(:inNeed).permit(:first_name, :last_name, :last4_ssn)
  end
end
