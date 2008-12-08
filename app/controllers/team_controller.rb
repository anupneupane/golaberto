class TeamController < ApplicationController
  N_("Team")

  before_filter :login_required, :except => [ :index, :list, :show ]

  def index
    redirect_to :action => :list
  end

  def show
    store_location
    @team = Team.find(params["id"])
    @championships = @team.team_groups.map{|t| t.group.phase.championship}.uniq.sort{|a,b| b.begin <=> a.begin}
  end

  def edit
    @team = Team.find(params["id"])
    @stadiums = Stadium.find(:all, :order => :name)
  end

  def update
    @team = Team.find(params["id"])
    @team.attributes = params["team"]
    foundation = params[:team].delete(:foundation)
    @team.foundation = Date.strptime(foundation, "%d/%m/%Y") unless foundation.empty?

    begin
      @team.save!
      @team.uploaded_logo(params[:logo], params[:filter]) unless params[:logo].to_s.empty?
      redirect_to :action => :show, :id => @team
    rescue
      @stadiums = Stadium.find(:all, :order => :name)
      render :action => :edit
    end
  end

  def list
    @id = params[:id]
    conditions = ["name LIKE ?", "%#{@id}%"] unless @id.nil?

    @teams = Team.paginate :order => "name",
                           :conditions => conditions,
                           :page => params[:page]
  end

  def new
    @team = Team.new
    @stadiums = Stadium.find(:all, :order => :name)
  end

  def create
    foundation = params[:team].delete(:foundation)
    @team = Team.new(params[:team])
    @team.foundation = Date.strptime(foundation, "%d/%m/%Y") unless foundation.empty?
    begin
      @team.save!
      @team.uploaded_logo(params[:logo], params[:filter]) unless params[:logo].to_s.empty?
      redirect_to :action => :show, :id => @team
    rescue
      @stadiums = Stadium.find(:all, :order => :name)
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