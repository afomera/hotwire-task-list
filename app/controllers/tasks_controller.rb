class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: [:destroy]

  def new
    @task = @list.tasks.new
  end

  def create
    @task = @list.tasks.new(task_params)

    if @task.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @task.list }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream }
        format.html { render :new }
      end
    end
  end

  def destroy
    @task.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@task) }
      format.html         { redirect_to lists_url(@list), notice: "Task removed" }
    end
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_task
    @task = @list.tasks.find(params[:id])
  end
end
