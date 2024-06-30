class Api::V1::TasksController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.all

    if params[:status]
      @tasks = @tasks.where(status: params[:status])
    end

    render json: @tasks
  end

  # GET /tasks/:id
  def show
    render json: @task
  end

  # POST /tasks
  def create
    if params[:status] == 'To Do' && too_many_todo_tasks?
      render json: { error: 'Cannot create more To Do tasks' }, status: :unprocessable_entity
    else
      task = Task.new(task_params)
      if task.save
        render json: task, status: :created
      else
        render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /tasks/:id
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/:id
  def destroy
    @task.destroy
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date, :reminder)
  end

  def too_many_todo_tasks?
    return false
  end
end
