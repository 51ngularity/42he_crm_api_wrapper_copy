class Person < CrmBase
  
  has_many :contact_details
  has_many :addrs
  has_many :tasks
  has_many :protocols
  has_many :activities
  has_many :positions
  has_many :companies
  has_many :tags
  has_many :custom_fields
    
  PERMITTED_PARAMS = [:first_name, :name, :background, :user_id, :title,
    :custom_field_attributes => CustomField::PERMITTED_PARAMS,
    :contact_detail_attributes => ContactDetail::PERMITTED_PARAMS,
    :addrs_attributes => Addr::PERMITTED_PARAMS]
    
#  class << self
#    #Search for People by name or first name
#    def search(name, first_name, per_page = 10)
#      find :all, 
#        :from => "/api/activities/search.json",
#        :per_page => per_page,
#        :params => {
#        :name => name, :first_name => first_name,
#      
#        :includes => "companies"
#      }
#    end
#  end
  
  def natural_name
    if self.first_name.blank?
      self.name
    else
      %{#{self.first_name} #{self.name}}
    end
  end
    
end

