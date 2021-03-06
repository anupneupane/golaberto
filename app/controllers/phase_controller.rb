class PhaseController < ApplicationController
  N_("Phase")

  require_role "editor"

  def new
    @phase = Phase.new
  end

  def create
    @phase = Phase.new(params["phase"])

    if @phase.save
      redirect_to :action => :show, :id => @phase
    else
      render :action => :new
    end
  end

  def edit
    @phase = Phase.find(params["id"])
  end

  def add_groups
    phase = Phase.find(params["id"])
    last_group = phase.groups[-1]
    4.times do
      new_name = returning last_group.name.split(" ") do |x|
        x[-1].succ!
      end.join " "
      last_group = phase.groups.build
      last_group.name = new_name
      last_group.save!
    end
    render :partial => "group_list", :object => phase
  end

  def update
    @phase = Phase.find(params["id"])
    @phase.attributes = params["phase"]

    saved = @phase.save
    new_empty = false

    @group = @phase.groups.build(params["group"])
    new_empty = @group.name.empty?

    saved = @group.save unless new_empty

    if saved and new_empty
      redirect_to :controller => :championship, :action => :phases, :id => @phase.championship, :phase => @phase
    else
      render :action => "edit"
    end
  end

  def destroy
    phase = Phase.find(params["id"])
    phase.destroy
    redirect_to :controller => :championship, :action => :edit, :id => phase.championship
  end
end
