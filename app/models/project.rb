class Project < CrmBase
  has_many :tasks, :class_name => 'task'
  has_many :protocols, :class_name => 'protocol'
  has_many :activities, :class_name => 'activity'
  has_many :tags, :class_name => 'tag'
    
  PERMITTED_PARAMS = [:company_id, :user_id, :deal_id, :name, :target_date, :finished_at, :current_state, :description,
    :person_ids_set => [], :custom_fields_attributes => CustomField::PERMITTED_PARAMS]
    
end