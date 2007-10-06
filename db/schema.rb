# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 10) do

  create_table "categories", :force => true do |t|
    t.column "name", :string
  end

  create_table "championships", :force => true do |t|
    t.column "name",        :string,                :default => "", :null => false
    t.column "begin",       :date,                                  :null => false
    t.column "end",         :date,                                  :null => false
    t.column "point_win",   :integer, :limit => 4,  :default => 3,  :null => false
    t.column "point_draw",  :integer, :limit => 4,  :default => 1,  :null => false
    t.column "point_loss",  :integer, :limit => 4,  :default => 0,  :null => false
    t.column "category_id", :integer, :limit => 20, :default => 0,  :null => false
  end

  create_table "comments", :force => true do |t|
    t.column "title",            :string,   :limit => 50, :default => ""
    t.column "comment",          :text
    t.column "created_at",       :datetime,                               :null => false
    t.column "commentable_id",   :integer,                :default => 0,  :null => false
    t.column "commentable_type", :string,   :limit => 15, :default => "", :null => false
    t.column "user_id",          :integer,                :default => 0,  :null => false
  end

  add_index "comments", ["user_id"], :name => "fk_comments_user"

  create_table "game_goals_versions", :id => false, :force => true do |t|
    t.column "game_version_id", :integer, :default => 0, :null => false
    t.column "goal_id",         :integer, :default => 0, :null => false
  end

  create_table "game_versions", :force => true do |t|
    t.column "game_id",    :integer
    t.column "version",    :integer
    t.column "home_id",    :integer,  :limit => 20, :default => 0
    t.column "away_id",    :integer,  :limit => 20, :default => 0
    t.column "phase_id",   :integer,  :limit => 20
    t.column "round",      :integer,  :limit => 4
    t.column "attendance", :integer,  :limit => 9
    t.column "stadium_id", :integer,  :limit => 20
    t.column "referee_id", :integer,  :limit => 20
    t.column "home_score", :integer,  :limit => 2,  :default => 0
    t.column "away_score", :integer,  :limit => 2,  :default => 0
    t.column "home_pen",   :integer,  :limit => 2
    t.column "away_pen",   :integer,  :limit => 2
    t.column "played",     :boolean,                :default => false
    t.column "date",       :date
    t.column "time",       :time
    t.column "updater_id", :integer,  :limit => 20, :default => 0,     :null => false
    t.column "updated_at", :datetime,                                  :null => false
  end

  create_table "games", :force => true do |t|
    t.column "home_id",    :integer,  :limit => 20, :default => 0,     :null => false
    t.column "away_id",    :integer,  :limit => 20, :default => 0,     :null => false
    t.column "phase_id",   :integer,  :limit => 20
    t.column "round",      :integer,  :limit => 4
    t.column "attendance", :integer,  :limit => 9
    t.column "stadium_id", :integer,  :limit => 20
    t.column "referee_id", :integer,  :limit => 20
    t.column "home_score", :integer,  :limit => 2,  :default => 0,     :null => false
    t.column "away_score", :integer,  :limit => 2,  :default => 0,     :null => false
    t.column "home_pen",   :integer,  :limit => 2
    t.column "away_pen",   :integer,  :limit => 2
    t.column "played",     :boolean,                :default => false, :null => false
    t.column "date",       :date,                                      :null => false
    t.column "time",       :time
    t.column "version",    :integer
    t.column "updater_id", :integer,  :limit => 20, :default => 0,     :null => false
    t.column "updated_at", :datetime,                                  :null => false
  end

  create_table "goals", :force => true do |t|
    t.column "player_id", :integer, :limit => 20, :default => 0,     :null => false
    t.column "game_id",   :integer, :limit => 20, :default => 0
    t.column "team_id",   :integer, :limit => 20, :default => 0,     :null => false
    t.column "time",      :integer, :limit => 4,  :default => 0,     :null => false
    t.column "penalty",   :boolean,               :default => false, :null => false
    t.column "own_goal",  :boolean,               :default => false, :null => false
  end

  add_index "goals", ["player_id", "game_id"], :name => "player"

  create_table "groups", :force => true do |t|
    t.column "phase_id",  :integer, :limit => 20, :default => 0,  :null => false
    t.column "name",      :string,                :default => "", :null => false
    t.column "promoted",  :integer, :limit => 2,  :default => 0,  :null => false
    t.column "relegated", :integer, :limit => 2,  :default => 0,  :null => false
  end

  create_table "phases", :force => true do |t|
    t.column "championship_id", :integer, :limit => 20, :default => 0,                                 :null => false
    t.column "name",            :string,                :default => "",                                :null => false
    t.column "order_by",        :integer, :limit => 4,  :default => 0,                                 :null => false
    t.column "sort",            :string,                :default => "pt, w, gd, gf, gp, g_away, name", :null => false
  end

  add_index "phases", ["championship_id"], :name => "championship"

  create_table "player_games", :force => true do |t|
    t.column "player_id", :integer, :limit => 20, :default => 0,     :null => false
    t.column "game_id",   :integer, :limit => 20, :default => 0,     :null => false
    t.column "team_id",   :integer, :limit => 20, :default => 0,     :null => false
    t.column "on",        :integer, :limit => 20, :default => 0,     :null => false
    t.column "off",       :integer, :limit => 20, :default => 0,     :null => false
    t.column "yellow",    :boolean,               :default => false, :null => false
    t.column "red",       :boolean,               :default => false, :null => false
  end

  create_table "players", :force => true do |t|
    t.column "name",      :string,              :default => "", :null => false
    t.column "position",  :string, :limit => 3
    t.column "birth",     :date
    t.column "country",   :string
    t.column "full_name", :string
  end

  create_table "referee_champs", :force => true do |t|
    t.column "referee_id",      :integer, :limit => 20, :default => 0, :null => false
    t.column "championship_id", :integer, :limit => 20, :default => 0, :null => false
  end

  create_table "referees", :force => true do |t|
    t.column "name",     :string, :default => "", :null => false
    t.column "location", :string
  end

  create_table "stadia", :force => true do |t|
    t.column "name", :string, :default => "", :null => false
  end

  create_table "team_groups", :force => true do |t|
    t.column "group_id", :integer, :limit => 20, :default => 0, :null => false
    t.column "team_id",  :integer, :limit => 20, :default => 0, :null => false
    t.column "add_sub",  :integer, :limit => 4,  :default => 0, :null => false
    t.column "bias",     :integer, :limit => 4,  :default => 0, :null => false
    t.column "comment",  :text
  end

  add_index "team_groups", ["group_id", "team_id"], :name => "group", :unique => true
  add_index "team_groups", ["id"], :name => "id"

  create_table "team_players", :force => true do |t|
    t.column "team_id",         :integer, :limit => 20, :default => 0, :null => false
    t.column "player_id",       :integer, :limit => 20, :default => 0, :null => false
    t.column "championship_id", :integer, :limit => 20, :default => 0, :null => false
  end

  create_table "teams", :force => true do |t|
    t.column "name",    :string, :default => "", :null => false
    t.column "country", :string, :default => "", :null => false
    t.column "logo",    :string
  end

  create_table "users", :force => true do |t|
    t.column "login",                     :string
    t.column "email",                     :string
    t.column "crypted_password",          :string,   :limit => 40
    t.column "salt",                      :string,   :limit => 40
    t.column "created_at",                :datetime
    t.column "updated_at",                :datetime
    t.column "remember_token",            :string
    t.column "remember_token_expires_at", :datetime
  end

end
