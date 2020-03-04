class Position < CrmBase
  
  PERMITTED_PARAMS = [:account_id, :person_id, :company_id, :name, 
  						:department, :primary_function, :former, :atype]
  
  def  company
    Company.find(self.company_id)
  end
  def person
    Person.find(self.person_id)
  end
end