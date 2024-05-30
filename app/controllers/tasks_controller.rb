class TasksController < ApplicationController
  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.save

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@task) }
      format.html { redirect_to @task }
    end
  end

  private
    def task_params
      params.require(:task).permit(:input)
    end
end
