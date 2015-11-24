module Api
	class ManagersController < ApiController
		before_filter :authenticate_manager!, only: [:current]
		def current
			@manager = current_manager
			if @manager
				render json: @manager, status: :ok						
			else
				render json: {errors: 'bad request or current manager not found'}, status: 400
			end
		end
	end
end