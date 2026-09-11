module Api
  module V1
    class PlantsController < ApplicationController
      # GET /api/v1/plants
      def index
        @plants = Plant.all
        render json: @plants
      end

      # POST /api/v1/plants
      def create
        plant = Plant.new(plant_params)

        if plant.save
          render json: plant, status: :created
        else
          render json: { errors: plant.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      # GET /api/v1/plants/trefle_search?query=Monstera
      def trefle_search
        query = params[:query]

        if query.blank?
          render json: { error: 'Query parameter is required' }, status: :bad_request
          return
        end

        raw_response = TrefleService.new.search_plant(query)

        if raw_response[:error]
          render json: { error: raw_response[:error] }, status: :bad_gateway
        else
          serialized_data = TreflePlantSerializer.render_collection(raw_response['data'])
          render json: { data: serialized_data }
        end
      end

      private
      def plant_params
        # Payload example: { plant: { "name": "Monstera" }}
        params.require(:plant).permit(:name)
      end
    end
  end
end
