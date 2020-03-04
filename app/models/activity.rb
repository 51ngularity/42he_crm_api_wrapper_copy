class Activity < CrmBase
  PERMITTED_PARAMS = [:attachable_id, :attachable_type, :user_id, :verb, :confidential, :name, :change]
end  
