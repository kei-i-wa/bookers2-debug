class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
def after_sign_in_path_for(resource)
user_path(@user.id)
end

end
