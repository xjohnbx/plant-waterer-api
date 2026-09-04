module Api
  module V1
    class PlantsController < ApplicationController
      # GET /api/v1/plants
      def index
        @plants = Plant.all
        render json: @plants
      end
    end
  end
end

# 1) Create getMyPlants() -> This will return via a route 2 plants, one of them being our Monstera.
#    * Create Plant type (This will be used in the future) <- How do we categorize this in .rb?
        # Is it a model or a type?
        # What is the naming convention for our local Plant object (The one we send to RN). vs. The one we get from APIs.
# 2) Launch This server
# 3) Connect to this server via the RN app and display the monstera.
# 4t) Test by changing the value in the local .db file and see if the name updates in the app.
#
