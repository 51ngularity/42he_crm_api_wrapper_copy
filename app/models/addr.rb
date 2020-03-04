class Addr < CrmBase
	#belongs_to :person

  PERMITTED_PARAMS = [:id, :attachable_id, :attachable_type, :street, :zip, :city, :country, :primary, :atype,
    :strasse, :plz, :ort, :land, :_destroy, :move_addr_id]
end
