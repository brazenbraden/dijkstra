# frozen_string_literal: true

require_relative "path"

class Dijkstra
  def initialize(graph)
    @graph = graph
    @paths = {}
  end

  def shortest_path(start:, finish:)
    current_path = Path.new(nil, graph.nodes[start])
    paths[start] = current_path

    while (current_path.head_name != finish)
      current_path.head.edges.each do |edge|

        tentative_effort = current_path.cumulative_effort + edge.effort
        if !paths[edge.node.name] || tentative_effort < paths[edge.node.name].cumulative_effort
          paths[edge.node.name] = Path.new(current_path, edge.node)
        end

        edge.node.delete!(current_path.head)
      end

      paths.delete(current_path.head_name)
      current_path = next_path
    end

    current_path
  end

  private

  attr_reader :graph, :paths

  def next_path
    paths.min_by { |_k, path| path.cumulative_effort }.last
  end
end
