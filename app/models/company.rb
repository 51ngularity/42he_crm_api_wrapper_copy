class Company < CrmBase    
  has_many :contact_details, :class_name => 'contact_detail'
  has_many :tasks, :class_name => 'task'
  has_many :protocols, :class_name => 'protocol'
  has_many :activities, :class_name => 'activity'
  has_many :positions, :class_name => 'position'
  has_many :tags, :class_name => 'tag'
  has_many :addrs, :class_name => 'addr'

  PERMITTED_PARAMS = [:name, :background, :user_id, :distance_to_user_zip,
      :custom_field_attributes => CustomField::PERMITTED_PARAMS,
      :contact_detail_attributes => ContactDetail::PERMITTED_PARAMS,
      :addrs_attributes => Addr::PERMITTED_PARAMS]
  
end