class Project < ApplicationRecord

  belongs_to :main_project,
             class_name: 'Project',
             foreign_key: :main_project_id,
             optional: true

  has_many :sub_projects,
           class_name: 'Project',
           foreign_key: :main_project_id

end
