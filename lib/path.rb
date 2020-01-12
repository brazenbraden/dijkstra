# frozen_string_literal: true

class Path < Array
  attr_reader :cumulative_effort
  alias head last

  def initialize(previous_path, next_node)
    if previous_path.nil?
      super [next_node]
      @cumulative_effort = 0
    else
      super previous_path.dup.push(next_node)

      @cumulative_effort = previous_path.cumulative_effort +
       previous_path.last.edges.find { |e| e.node == next_node }.effort
    end
  end

  def to_s
    self.map(&:name).join
  end

  def pretty
    current_effort = 0
    str = "#{self[0].name}(0)"

    1.upto(self.size-1) do |i|
      next_node = self[i]
      effort = self[i-1].edges.find { |e| e.node == next_node }.effort
      current_effort += effort

      str += " -#{effort}-> #{next_node.name}(#{current_effort})"
    end

    str
  end

  def head_name
    self.last.name
  end
end
