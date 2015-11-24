module Api
	class ApiController < ApplicationController

		def self.authenticate
			# not sure what we need, so, try
		end

		def self.verify_api_token
			# input token validation and make this method before action
			# for all derivated controllers
			true
		end
	end
end