class ServiceController < ApplicationController
  respond_to :json

# For anyone to assign services in need, given an id.
# {
	# "names": "[legal, medical]",
	# "in_need_id": 1,
	# descriptions "["For legal i am looking for...", "For legal i am looking for..."]"
# }
  def newServices
    params[:services][:names].zip(params[:services][:descriptions]).each do |name, description|

      if Service.find_by(name: name, in_need_id: params[:services][:in_need_id]).nil?
        service = Service.new(name: name, being_served: false, volunteer_id: -1, in_need_id: params[:services][:in_need_id], description: description)
        service.save
      end
    end
      services = []

      Service.where(in_need_id: params[:services][:in_need_id]).find_each do |serv|
        services.push(serv.as_json)
      end

      render :json => {:services => services}
  end

# For anyone to delete services in need, given an id.
# {
	# "names": "[legal, medical]",
	# "in_need_id": 1
# }
  def deleteServices
    for name in params[:services][:names]
      service = Service.find_by(name: name, in_need_id: params[:services][:in_need_id])
      if !service.nil?
        service.destroy
      end
    end
      services = []
      Service.where(in_need_id: params[:services][:in_need_id]).find_each do |serv|
        services.push(serv.as_json)
      end

      render :json => {:services => services}
  end

# For anyone to mark as service as being served 
  def markServiceBeingServed

    service = Service.find_by(name: params[:name], in_need_id: params[:in_need_id])
    if !service.nil?
      service.volunteer_id = params[:volunteer_id]
      service.being_served = true
      service.save
    end
    render :json => {:service => Service.all}
  end

# For anyone to mark as service as being served 
  def unmarkServiceBeingServed

    service = Service.find_by(name: params[:name], in_need_id: params[:in_need_id], volunteer_id: params[:volunteer_id])
    if !service.nil?
      service.volunteer_id = -1
      service.being_served = false
      service.save
    end
    render :json => {:service => service}
  end

# For a given volounteer, grab all services they can help.
  def getServicesUnserved
    services_to_return = []
    volunteer = User.find(params[:volunteer_id])
    if !volunteer.nil?
      Service.where(being_served: false).find_each do |service|
        if(volunteer.services.include?(service.name) || service.name == "custom")
          services_to_return.push(service.as_json)
        end
      end
    end
    render :json => {:services => services_to_return}
  end


private
  def service_params
    params.require(:services).permit(:in_need_id, :name, :volunteer_id, :names => [], :descriptions => [])
  end
end
