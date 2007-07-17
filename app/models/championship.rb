class Championship < ActiveRecord::Base
  has_many :phases, :order => "order_by", :dependent => :destroy
  has_many :team_players, :dependent => :delete_all
  validates_presence_of :name
  validates_presence_of :begin
  validates_presence_of :end
  validates_numericality_of :point_win, :only_integer => true
  validates_numericality_of :point_draw, :only_integer => true
  validates_numericality_of :point_loss, :only_integer => true
  
  # Fields information, just FYI.
  #
  # Field: id , SQL Definition:bigint(20)
  # Field: name , SQL Definition:varchar(255)
  # Field: begin , SQL Definition:date
  # Field: end , SQL Definition:date
  # Field: point_win , SQL Definition:tinyint(4)
  # Field: point_draw , SQL Definition:tinyint(4)
  # Field: point_loss , SQL Definition:tinyint(4)

  def full_name
    name = self.name + " " + self.begin.year.to_s
    if self.begin.year != self.end.year
      name += "/" + self.end.year.to_s
    end
    name
  end
end
