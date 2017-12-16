class Task < ApplicationRecord

  belongs_to :project
  belongs_to :user

  enum status: {
      new:               0,
      resolved:          1,
      feedback_required: 2,
      reopened:          3,
      closed:            4,
      rejected:          5
  }

  enum tracker: {
      bug:      0,
      feature:  1,
      improve:  2,
      support:  3,
      estimate: 4
  }

end
