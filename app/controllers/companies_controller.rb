class CompaniesController < ApplicationController

	require 'csv'

	def index

		if !params[:zip_of_user].to_i.present? || !params[:max_distance].to_f.present? || (params[:zip_of_user].to_s.length != 5 && params[:zip_of_user].to_s.length != 4) 
			params[:max_distance] = ''
			params[:zip_of_user] = ''
		elsif params[:max_distance].to_f > 200 
			params[:max_distance] = ''
			params[:zip_of_user] = ''
		end

		#@x = params[:max_distance].to_f.present?

		if !params[:order]
			params[:order] = 'name-asc' 
		end
		
		# if max_distance and user_zip valid, calculate distances:
		if params[:max_distance].length != 0 && params[:zip_of_user].length != 0
			earth_R = 6371
			zip_geodata_de = CSV.read('app/assets/geodata/zip_geodata_de.csv', col_sep: "\t", converters: :numeric, headers: true)
			
			@companies = Company.all(params: {order: params[:order], includes: 'all', perpage: 500})

			if zip_geodata_de['PLZ'].find_index( params[:zip_of_user].to_i ).present?
				i = zip_geodata_de['PLZ'].find_index( params[:zip_of_user].to_i )
				r = 3
				lat_user = zip_geodata_de['Latitude'][i].round(r)
				long_user = zip_geodata_de['Longitude'][i].round(r)

				@companies.each do |company|
					if company.addrs.present?
						if company.addrs.first.zip.present?
							if company.addrs.first.zip.to_i.present?
								i = zip_geodata_de['PLZ'].find_index(company.addrs.first.zip.to_i)

								if i.present?
									lat_company = zip_geodata_de['Latitude'][i].round(r)
									long_company = zip_geodata_de['Longitude'][i].round(r)

									# calculate distances	
									company.distance_to_user_zip = (earth_R * ( ((lat_user - lat_company)*2*Math::PI/360)**2 + ((long_user - long_company)*2*Math::PI/360)**2 )**0.5).round(1)
								else
									company.distance_to_user_zip = 10000
								end
							else
								company.distance_to_user_zip = 10000
							end
						else
							company.distance_to_user_zip = 10000
						end
					else
						company.distance_to_user_zip = 10000
					end
				end

				# sort by distance
				if params[:order] == 'distance_to_user_zip-asc' || params[:order] == 'distance_to_user_zip-desc'
					@companies = @companies.sort_by { |obj| obj.distance_to_user_zip }

					if params[:order] == 'distance_to_user_zip-desc' 
						@companies = @companies.reverse
					end
				end

			else
				params[:max_distance] = ''
				params[:zip_of_user] = ''
			end
		else
			params[:max_distance] = ''
			params[:zip_of_user] = ''
			@companies = Company.all(params: {order: params[:order], includes: 'all', perpage: 500})
		end
	end

	def company_params
		params.require(:company).permit(Company::PERMITTED_PARAMS)
	end

	def show
		@company = Company.find(params[:id], params: {includes: 'all'})
	end
end