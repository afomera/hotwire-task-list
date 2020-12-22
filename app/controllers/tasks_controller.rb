class TasksController < ApplicationController
  before_action :set_list

  def new
    @task = @list.tasks.new
  end

  def create
    @task = @list.tasks.new(task_params)

    if @task.save
      # TODO AC response
      respond_to do |format|
        format.html { redirect_to @task.list }
      end
    else
      render :new
    end
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
