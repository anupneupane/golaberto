class TeamController < ApplicationController
  N_("Team")

  authorize_resource

  def index
    redirect_to :action => :list
  end

  def show
    store_location
    @team = Team.find(params["id"])
    @championships = @team.team_groups.map{|t| t.group.phase.championship}.uniq.sort{|a,b| b.begin <=> a.begin}
    @next_games = @team.next_n_games(5, { :date => Date.today })
    @last_games = @team.last_n_games(5, { :date => Date.today })
  end

  def edit
    @team = Team.find(params["id"])
    @stadiums = Stadium.order(:name)
  end

  def games
    store_location
    @categories = Category.all
    @team = Team.find(params["id"])
    @category = Category.find(params[:category])
    @played = params[:played]
    order = !!@played ? "date DESC" : "date ASC"
    @games = Game.team_games(@team).paginate(:page => params[:page], :order => order, :conditions => [ "played = ? and championships.category_id = ?", @played, @category ], :include => { :phase => :championship })
  end

  def update
    @team = Team.find(params["id"])
    @team.attributes = params["team"]

    begin
      @team.save!
      @team.uploaded_logo(params[:logo], params[:filter]) unless params[:logo].to_s.empty?
      redirect_to :action => :show, :id => @team
    rescue
      @stadiums = Stadium.order(:name)
      render :action => :edit
    end
  end

  def list
    @id = params[:id]
    conditions = ["name LIKE ?", "%#{@id}%"] unless @id.nil?

    @teams = Team.paginate :order => "name",
                           :conditions => conditions,
                           :page => params[:page]
    if @teams.size == 1
      redirect_to :action => :show, :id => @teams.first
    end
  end

  def new
    @team = Team.new
    @stadiums = Stadium.order(:name)
  end

  def create
    @team = Team.new(params[:team])
    begin
      @team.save!
      @team.uploaded_logo(params[:logo], params[:filter]) unless params[:logo].to_s.empty?
      redirect_to :action => :show, :id => @team
    rescue
      @stadiums = Stadium.order(:name)
      render :action => :new
    end
  end

  def destroy
    team = Team.find(params[:id]).destroy
    redirect_to :action => :list
  end

  def auto_complete_for_team_name
    search = params[:team][:name]
    @teams = Team.find(
        :all,
        :conditions => "name like '#{search}%'",
        :order => "name",
        :limit => 5) unless search.blank?
    render :partial => "search" 
  end
end
