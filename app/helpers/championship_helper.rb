module ChampionshipHelper
  class TeamCampaign
    attr_reader :points, :games, :wins, :draws, :losses,
                :goals_for, :goals_against, :goals_pen, :goals_away,
                :last_game, :next_game

    def initialize(team_group, games)
      @games = 0
      @points = 0
      @wins = 0
      @draws = 0
      @losses = 0
      @goals_for = 0
      @goals_against = 0
      @goals_pen = 0
      @goals_away = 0
      @last_game = nil
      @next_game = nil
      if (games.size == 0)
        return
      end
      team = team_group.team
      championship = games[0].phase.championship unless games[0].nil?
      points_for_win = championship.point_win
      points_for_draw = championship.point_draw
      points_for_loss = championship.point_loss
      add_sub = team_group.add_sub
      games.select do |x|
        (x.home_id == team.id or
         x.away_id == team.id) and
         x.played?
      end.each do |game|
        @games += 1
        if (game.home_id == team.id) then 
          @goals_pen += game.home_pen unless game.home_pen.nil?
        else
          @goals_pen += game.away_pen unless game.home_pen.nil?
          @goals_away += game.away_score
        end
        if game.home_score > game.away_score then
          if (game.home_id == team.id) then 
            @wins += 1
            @points += points_for_win
          else
            @losses += 1
            @points += points_for_loss
          end
        elsif game.home_score < game.away_score then
          if (game.home_id == team.id) then 
            @losses += 1
            @points += points_for_loss
          else
            @wins += 1
            @points += points_for_win
          end
        else
          @draws += 1
          @points += points_for_draw
        end
        if (game.home_id == team.id) then
          @goals_for += game.home_score
          @goals_against += game.away_score
        else
          @goals_against += game.home_score
          @goals_for += game.away_score
        end
      end
      @last_game = games.select do |x|
        (x.home_id == team.id or
         x.away_id == team.id) and
         x.played?
      end.last
      @next_game = games.select do |x|
        (x.home_id == team.id or
         x.away_id == team.id) and
         !x.played?
      end.first
      @points += add_sub
    end

    def goals_diff
      @goals_for - @goals_against 
    end

    def goals_avg
      @goals_for / (@goals_against + 0.0000001)
    end
  end
end
