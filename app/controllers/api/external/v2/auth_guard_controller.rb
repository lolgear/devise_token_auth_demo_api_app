module Api
	module External
		module V2
			class AuthGuardController < ActionController::Base
			  include DeviseTokenAuth::Concerns::SetUserByToken

			end
		end
	end
end