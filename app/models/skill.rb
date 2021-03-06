class Skill < ActiveRecord::Base
	belongs_to :user
	belongs_to :language
  validates :language_id, presence: true
  before_update :previous_exp
  after_update :get_level
  before_save :default_exp
  before_save :get_level

  def previous_exp
    prev = self.experience if self.experience_changed?
  end

  def default_exp
    self.experience = 0 if self.experience.nil?
  end

  def get_level
    level = 0
    multiplier = 2000
    exp = self.experience.dup.to_i
    exp_needed = 2000
    while (exp - exp_needed > 0)
      #follows geometric Function to calculate current Level
      exp_needed = (multiplier*2**level)
      level += 1
    end
    {name: self.language.name, level: level, next_level: level+1, next_requires: exp_needed, exp_left: exp_needed-exp, exp: exp, level_percent: (exp/exp_needed*100) }
  end

  def next_level
    self.get_level.next_level
  end

  def exp_needed
    self.get_level.next_requires
  end

  def level
  self.get_level.level
  end
end