class SkillsController < ApplicationController

  def index
    user = User.find(params[:user_id])
    user.initial_api
    user.skill_adding
    full_skill = []
    user.skills.each do |skill|
      full_skill << {
        id: skill.id,
        user_id: skill.user_id,
        old_exp: skill.previous_exp,
        exp: skill.experience,
        language: skill.language,
        updated_at: skill.updated_at,
        added_at: skill.created_at
      }
    end
    render json: full_skill
  end


  private

end
