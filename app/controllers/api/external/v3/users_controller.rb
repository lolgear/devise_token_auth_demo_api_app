module Api
	module External
		module V3
			class UsersController < AuthGuardController
				before_filter :authenticate_user!, only: [:current]
				def current
					@user = current_user
					puts "errors are: #{@user.errors.to_hash}"
					puts "current user is: #{@user}"
					if @user
						render json: @user, status: :ok						
					else
						render json: {errors: 'bad request or current user not found'}, status: 400
					end
				end
			end
		end
	end
end