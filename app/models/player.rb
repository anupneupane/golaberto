class Player < ActiveRecord::Base
  has_many :comments, :as => :commentable, :dependent => :destroy, :order => 'created_at ASC'
  has_many :goals, :dependent => :delete_all
  has_many :team_players, :dependent => :delete_all
  has_many :player_games, :dependent => :delete_all

  validates_length_of :name, :within => 1..40

  Positions = %w(g dr dc dl dm cm am fw)
  validates_inclusion_of :position, :in => Positions, :allow_nil => true

  # Fields information, just FYI.
  #
  # Field: id , SQL Definition:bigint(20)
  # Field: name , SQL Definition:varchar(255)
  # Field: position , SQL Definition:tinytext
  # Field: birth , SQL Definition:date
  # Field: country , SQL Definition:varchar(255)
  # Field: full_name , SQL Definition:varchar(255)

  def self.compare_position(a, b)
    if a.nil? and b.nil?
      0
    elsif a.nil?
      1
    elsif b.nil?
      -1
    else
      Positions.index(a) <=> Positions.index(b)
    end
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
