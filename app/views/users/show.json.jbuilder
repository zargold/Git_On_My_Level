json.extract! @user, :id, :email, :logins, :last_rescued, :created_at, :updated_at
json.extract! @level_info, :next_level, :exp_left, :next_requires, :exp, :guild if @user.skills.any?&&@level_info