# frozen_string_literal: true
require_relative "node"

class Graph
  attr_reader :nodes

  def initialize
    @nodes = {}
  end

  def add_edge(point_a, point_b, effort:, one_way: false)
    node_a = nodes[point_a] ||= Node.new(point_a)
    node_b = nodes[point_b] ||= Node.new(point_b)

    node_a.add_edge(node_b, effort)
    node_b.add_edge(node_a, effort) unless one_way

    nodes[point_a] = node_a
    nodes[point_b] = node_b

    self
  end
end
