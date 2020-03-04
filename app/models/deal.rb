
  class Deal < CrmBase
    has_many :tasks, :class_name => 'task'
    has_many :protocols, :class_name => 'protocol'
    has_many :activities, :class_name => 'activity'
    has_many :tags, :class_name => 'tag'
    
    PERMITTED_PARAMS = [:company_id, :user_id, :name, :value, :value_type, 
      :target_date, :finished_at, :current_state, :value_count, :description, :currency,
      :person_ids_set => [], :custom_fields_attributes => CustomField::PERMITTED_PARAMS]
    
  end
