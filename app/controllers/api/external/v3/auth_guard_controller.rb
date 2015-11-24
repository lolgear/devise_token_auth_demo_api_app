module Api
	module External
		module V3
			class AuthGuardController < ActionController::Base
			  include DeviseTokenAuth::Concerns::SetUserByToken

			end
		end
	end
end