# frozen_string_literal: true

class Edge
  attr_reader :node, :effort

  def initialize(node, effort)
    @node = node
    @effort = effort
  end
end
