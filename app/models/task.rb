class Task < CrmBase
  PERMITTED_PARAMS = [:user_id, :attachable_id, :attachable_type, :finished,
      :name, :precise_time, :end_time, :fuzzy, :entire_day, :badge]
   
end