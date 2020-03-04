  class Protocol < CrmBase
    PERMITTED_PARAMS = [:user_id, :name, :confidential, :content, 
      :type, :badge, :uploaded_files]
  end